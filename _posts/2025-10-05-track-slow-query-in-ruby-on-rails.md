---
layout: single
title: Track Slow Query in Ruby on Rails
date: 2025-10-05 12:28 +0700
description: "Tips to track Rails app slow query on development and staging environment"
comments: true
toc: true
toc_sticky: true
categories:
- Technology
- Level Beginner
tags:
- Rails
header:
  image: /assets/images/track-slow-query.jpg
  image_description: https://unsplash.com/photos/man-rubbing-his-face-in-front-of-laptop-bl7h_R-PKpU
---

**Performance bottlenecks** in web applications often lurk beneath the surface, only becoming obvious when they impact user experience or cause infrastructure costs to spike. In Ruby on Rails projects, identifying slow database queries early—during development or in non-production (staging) environments—can save hours of debugging down the line. By proactively tracking and analyzing these slow queries, engineers can address inefficiencies before they reach production, ensuring smoother deployments and a more responsive app for end users.

# Tracker

Let's define the tracker:

```ruby
unless Rails.env.production?
  ActiveSupport::Notifications.subscribe('sql.active_record') do |_name, start, finish, _id, payload|
    backtrace = Rails.backtrace_cleaner.clean(caller)
    # Find the first relevant line in the backtrace
    caller_location = backtrace.detect { |line| line.start_with?('app/') }
    duration = finish - start
    # threshold is 1.0 for controller, and 5 seconds for sidekiq (app/workers)
    threshold = if caller_location&.include?('app/controllers')
      1.0
    elsif caller_location&.include?('app/workers')
      5.0
    else
      0.5
    end
    # Skip tracking if this is already an EXPLAIN query to prevent infinite loops
    return if payload[:sql].strip.start_with?('EXPLAIN')
    if duration > threshold
      # Enqueue slow query analysis to background worker to avoid blocking the main thread
      Cosmos::SlowQueryTrackerWorker.perform_async(
        payload[:sql], payload[:name], duration, backtrace,
      )
    end
  end
end
```

# Reporter
Here is the main logic:

```ruby
class SlowQueryTrackerWorker < ApplicationWorker
  def perform(payload_sql, payload_name, duration, backtrace)
    # Use Rails cache to deduplicate within 5 minutes
    sql_hash = Digest::MD5.hexdigest(payload_sql)
    cache_key = "slow_query_tracker:#{sql_hash}"

    # Skip if we've already processed this query recently
    Rails.cache.fetch(cache_key, expires_in: 5.minutes) do
      analyze_slow_query(payload_sql, payload_name, duration, backtrace)
      true # Store something in cache to mark as processed
    end
  end

  private

  def analyze_slow_query(payload_sql, payload_name, duration, backtrace)
    # Only run EXPLAIN on SELECT queries to avoid unsafe SQL interpolation
    # Skip if the query is already an EXPLAIN query to avoid double EXPLAIN
    sql_stripped = payload_sql.strip
    return unless sql_stripped =~ /\ASELECT\b/i && !sql_stripped.start_with?('EXPLAIN')
    
    connection = ActiveRecord::Base.connection
    begin
      # Using EXPLAIN ANALYZE can be slow, but gives more accurate data.
      # Let's prefer EXPLAIN for speed to avoid making things even slower.
      # In MySQL, EXPLAIN output is a result set.
      explain_result = connection.execute("EXPLAIN #{payload_sql}")

      # Use array and join for better performance instead of string concatenation
      explain_rows = []
      rows = []
      explain_result.each(as: :hash) do |row|
        explain_rows << row
        rows << row.to_s
      end
      explain_output = rows.join("\n")

      # Heuristics for a "bad" query plan using structured data instead of string matching
      # type: ALL -> Full table scan
      # Extra: Using filesort -> Inefficient sorting
      # Extra: Using temporary -> Temp table creation is slow
      # rows: High row estimates (> 10_000) indicate potential performance issues
      # filtered: Low filtered percentage (< 10%) indicates inefficient filtering
      is_bad_plan = explain_rows.any? do |row|
        # Check for full table scan
        full_table_scan = (row['type'] == 'ALL')
        # Check for inefficient operations
        using_filesort = row['Extra']&.include?('Using filesort')
        using_temporary = row['Extra']&.include?('Using temporary')
        # Check for high row estimates
        rows_count = row['rows'].to_i
        high_rows = rows_count > 10_000
        # Check for low filtered percentage
        filtered_percent = row['filtered'].to_f
        low_filtered = filtered_percent < 10.0 && filtered_percent > 0
        # Consider range/index scans problematic if combined with high rows
        range_or_index_with_high_rows = (
          %w[range index].include?(row['type']) && high_rows
        )
        full_table_scan || using_filesort || using_temporary ||
          (high_rows && row['type'] != 'const') ||
          low_filtered || range_or_index_with_high_rows
      end

      # If the plan is bad, report it. Otherwise, we do not report the slow query.
      # Note: This approach may miss slow queries caused by factors not visible in the plan (e.g., large result sets, lock contention).
      # The filtering is intended to reduce noise and focus on queries with actionable inefficiencies.
      if is_bad_plan
        APM.report("Slow Query with inefficient plan (#{duration.round(2)} s) in #{payload_name}",
          {
            duration: duration,
            name: payload_name,
            sql: payload_sql,
            backtrace: backtrace,
            explain_output: explain_output,
          }
        )
      end

    rescue ActiveRecord::StatementInvalid => e
      # If EXPLAIN fails (e.g., for non-SELECT queries), just report the slow query as before.
      APM.report("Slow Query (#{duration.round(2)} s) in #{payload_name}",
        {
          duration: duration,
          name: payload_name,
          sql: payload_sql,
          backtrace: backtrace,
          explain_error: e.message,
        }
      )
    end
  end
end
```

*Originally posted on X by [Saiqul Haq](https://x.com/saiqulhaq/status/1961014523600707625), August 28, 2025.*