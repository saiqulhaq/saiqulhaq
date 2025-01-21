---
layout: single
title: Tips on storing logs to OpenSearch using Fluentbit
date: 2025-01-21 15:13 +0700
comments: true
toc: true
toc_sticky: true
categories:
- Technology
- Level Beginner
tags:
- Fluentbit
- OpenSearch
header:
  image: https://images.unsplash.com/photo-1455849318743-b2233052fcff?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1280&q=80&h=300
  image_description: https://unsplash.com/photos/two-person-standing-on-gray-tile-paving-TamMbr4okv4

---
Effectively storing logs in OpenSearch using Fluent Bit involves addressing challenges such as chunk flushing failures, buffer overflow, data backpressure, and optimizing index and shard configurations. By fine-tuning Fluent Bit settings, enabling verbose logging for debugging, implementing Index State Management policies, and leveraging performance monitoring tools like Grafana, these strategies ensure efficient log delivery, robust data retention, and improved cluster performance.

## Buffer Overflow Management
Buffer size limitations in Fluent Bit can significantly impact log processing efficiency and data retention. The `mem_buf_limit` parameter controls the maximum memory buffer size for input plugins, typically set in megabytes [1](https://docs.fluentbit.io/manual/administration/buffering-and-storage). When this limit is reached, Fluent Bit pauses the input plugin, potentially leading to data loss [2](https://chronosphere.io/learn/avoiding-data-loss-and-backpressure-problems-with-fluent-bit/). To mitigate this issue, consider the following strategies:

*   Enable filesystem buffering by setting `storage.type` to `filesystem`, which allows Fluent Bit to write excess data to disk when memory limits are reached [1](https://docs.fluentbit.io/manual/administration/buffering-and-storage) [2](https://chronosphere.io/learn/avoiding-data-loss-and-backpressure-problems-with-fluent-bit/).
*   Adjust `storage.max_chunks_up` to control the number of chunks kept in memory, with each chunk typically around 2MB [1](https://docs.fluentbit.io/manual/administration/buffering-and-storage).
*   Implement `storage.total_limit_size` for output plugins to manage disk space usage for buffered chunks [1](https://docs.fluentbit.io/manual/administration/buffering-and-storage).

These configurations help balance memory usage, prevent data loss, and maintain service stability during high-volume log ingestion scenarios.


---
**Sources:**
- [(1) Buffering & Storage | Fluent Bit: Official Manual](https://docs.fluentbit.io/manual/administration/buffering-and-storage)
- [(2) Avoiding data loss and backpressure problems with Fluent Bit](https://chronosphere.io/learn/avoiding-data-loss-and-backpressure-problems-with-fluent-bit/)


## Handling Data Backpressure
Backpressure in Fluent Bit occurs when data is ingested faster than it can be flushed to destinations, leading to high memory consumption and potential service disruptions [1](https://docs.fluentbit.io/manual/1.7/administration/backpressure) [2](https://docs.fluentbit.io/manual/concepts/buffering). To mitigate this issue, Fluent Bit implements a mechanism that restricts data ingestion using the `Mem_Buf_Limit` parameter [3](https://docs.fluentbit.io/manual/administration/backpressure). When this limit is reached, the input plugin pauses, emitting a warning message, and resumes once buffer memory becomes available [3](https://docs.fluentbit.io/manual/administration/backpressure).

To address backpressure:

*   Enable filesystem buffering by setting `storage.type` to `filesystem`, allowing Fluent Bit to write excess data to disk [3](https://docs.fluentbit.io/manual/administration/backpressure) [4](https://chronosphere.io/learn/avoiding-data-loss-and-backpressure-problems-with-fluent-bit/).
*   Implement rate limiting or throttling to match the system's processing capacity [5](https://www.linkedin.com/advice/0/how-do-you-handle-backpressure-streaming-skills-distributed-systems).
*   Use monitoring tools to track buffer sizes, errors, and set up alerts for potential backpressure scenarios [5](https://www.linkedin.com/advice/0/how-do-you-handle-backpressure-streaming-skills-distributed-systems) [4](https://chronosphere.io/learn/avoiding-data-loss-and-backpressure-problems-with-fluent-bit/).
*   Consider scaling or partitioning to distribute data processing across multiple units [5](https://www.linkedin.com/advice/0/how-do-you-handle-backpressure-streaming-skills-distributed-systems).

These strategies help maintain data flow, prevent data loss, and ensure system stability during high-volume log ingestion [4](https://chronosphere.io/learn/avoiding-data-loss-and-backpressure-problems-with-fluent-bit/).


---
**Sources:**
- [(1) Backpressure | Fluent Bit: Official Manual](https://docs.fluentbit.io/manual/1.7/administration/backpressure)
- [(2) Buffering - Fluent Bit: Official Manual](https://docs.fluentbit.io/manual/concepts/buffering)
- [(3) Backpressure | Fluent Bit: Official Manual](https://docs.fluentbit.io/manual/administration/backpressure)
- [(4) Avoiding data loss and backpressure problems with Fluent Bit](https://chronosphere.io/learn/avoiding-data-loss-and-backpressure-problems-with-fluent-bit/)
- [(5) How do you handle backpressure in streaming? - LinkedIn](https://www.linkedin.com/advice/0/how-do-you-handle-backpressure-streaming-skills-distributed-systems)


## Chunk Flushing Failures.
Chunk flushing failures in Fluent Bit are often indicative of underlying issues with buffer management and data transmission. These failures can occur when the system struggles to send log data to the designated output, such as OpenSearch. To diagnose the root cause, enabling `Trace_Error On` in the Fluent Bit configuration provides detailed error messages and stack traces [1].

Common reasons for chunk flushing failures include:

*   Buffer size limitations: If the `Buffer_Chunk_Size` is too small for the volume of logs being processed, it can lead to frequent flushing attempts and failures [2](https://forum.opensearch.org/t/try-the-understand-the-error-failed-to-write-the-request-of-size-4580301-due-to-buffer-capacity-too-small-for-the-number-of-records-18005/20664) [3](https://docs.fluentbit.io/manual/1.8/administration/buffering-and-storage).
*   Network connectivity issues: Intermittent network problems can cause failures when attempting to send data to the output destination [4](https://stackoverflow.com/questions/72624921/why-i-get-the-failed-to-flush-chunk-error-in-fluent-bit).
*   Output endpoint capacity: The receiving end (e.g., OpenSearch) may be overwhelmed, causing it to reject incoming data [2](https://forum.opensearch.org/t/try-the-understand-the-error-failed-to-write-the-request-of-size-4580301-due-to-buffer-capacity-too-small-for-the-number-of-records-18005/20664).
*   Configuration mismatches: Incorrect settings for authentication, SSL/TLS, or endpoint URLs can prevent successful data transmission [5](https://knowledge.broadcom.com/external/article/373718/fluent-bit-does-not-forward-some-pod-log.html).

To mitigate these issues, consider increasing buffer sizes, implementing backpressure handling, and ensuring proper network connectivity between Fluent Bit and the output service [6](https://chronosphere.io/learn/avoiding-data-loss-and-backpressure-problems-with-fluent-bit/). Additionally, monitoring Fluent Bit's performance metrics and setting up alerts can help proactively identify and address potential problems before they escalate [7](https://chronosphere.io/learn/fluent-bit-alerting-slack/).


---
**Sources:**
- (1) paste.txt
- [(2) Try the understand the error Failed to write the request of size ...](https://forum.opensearch.org/t/try-the-understand-the-error-failed-to-write-the-request-of-size-4580301-due-to-buffer-capacity-too-small-for-the-number-of-records-18005/20664)
- [(3) Buffering & Storage | Fluent Bit: Official Manual](https://docs.fluentbit.io/manual/1.8/administration/buffering-and-storage)
- [(4) Why I get the failed to flush chunk error in fluent-bit? - Stack Overflow](https://stackoverflow.com/questions/72624921/why-i-get-the-failed-to-flush-chunk-error-in-fluent-bit)
- [(5) Fluent Bit does not forward some pod logs due to warn http\_client ...](https://knowledge.broadcom.com/external/article/373718/fluent-bit-does-not-forward-some-pod-log.html)
- [(6) Avoiding data loss and backpressure problems with Fluent Bit](https://chronosphere.io/learn/avoiding-data-loss-and-backpressure-problems-with-fluent-bit/)
- [(7) Use Fluent Bit logs to monitor your pipeline and send alerts to Slack](https://chronosphere.io/learn/fluent-bit-alerting-slack/)


## Optimizing Index Management Strategies
Index State Management (ISM) policies are crucial for efficient index management in OpenSearch and Elasticsearch clusters. These policies automate routine tasks based on index age, size, or document count, helping to optimize cluster performance [1](https://opensearch.org/docs/latest/im-plugin/ism/index/) [2](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/ism.html). For high-volume indices exceeding 500MB per day, daily rotations are recommended, while medium and low-volume indices benefit from weekly and monthly rotations respectively [3](https://www.elastic.co/guide/en/elasticsearch/reference/7.17/size-your-shards.html).

To improve index management:

*   Implement ISM policies to automate index lifecycle management, including transitions between states like `read_only` and eventual deletion [1](https://opensearch.org/docs/latest/im-plugin/ism/index/) [2](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/ism.html).
*   Consolidate small indices to reduce cluster state overhead and improve search performance [4](https://stackoverflow.com/questions/34520201/elasticsearch-shard-allocation-for-small-indices).
*   Adjust shard configurations based on data volume, aiming for optimal shard sizes around 50GB [5](https://www.elastic.co/guide/en/elasticsearch/reference/current/size-your-shards.html).
*   Use `max_primary_shard_size` instead of `max_age` for rollovers to avoid creating empty or small shards [3](https://www.elastic.co/guide/en/elasticsearch/reference/7.17/size-your-shards.html).
*   Consider longer time periods for index creation to reduce overall shard count and improve cluster health [5](https://www.elastic.co/guide/en/elasticsearch/reference/current/size-your-shards.html) [3](https://www.elastic.co/guide/en/elasticsearch/reference/7.17/size-your-shards.html).


---
**Sources:**
- [(1) Index State Management - OpenSearch Documentation](https://opensearch.org/docs/latest/im-plugin/ism/index/)
- [(2) Index State Management in Amazon OpenSearch Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/ism.html)
- [(3) Size your shards | Elasticsearch Guide 7.17 | Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/7.17/size-your-shards.html)
- [(4) Elasticsearch shard allocation for small indices - Stack Overflow](https://stackoverflow.com/questions/34520201/elasticsearch-shard-allocation-for-small-indices)
- [(5) Size your shards | Elasticsearch Guide 8.17 | Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/size-your-shards.html)


## Enabling Verbose Logging
To enable verbose mode in Fluent Bit for debugging purposes, configure the following settings in your Fluent Bit configuration file:

*   In the `[SERVICE]` section:
```text
    [SERVICE]
    Log_Level       debug
```
    
*   In the `[OUTPUT]` section:
```text
    [OUTPUT]
    Trace_Error     On
    Trace_Output    On
```
    

The `Log_Level debug` setting increases the verbosity of Fluent Bit's general logging, providing more detailed information about its operations [1](https://docs.fluentbit.io/manual/administration/configuring-fluent-bit/classic-mode/configuration-file) [2](https://docs.fluentbit.io/manual/3.1/administration/configuring-fluent-bit/classic-mode/configuration-file). This level is cumulative, meaning it includes all less verbose levels (error, warn, and info) in addition to debug messages [3](https://stackoverflow.com/questions/78254735/fluent-bit-multiple-log-level-values).

`Trace_Error On` enables detailed error tracing, providing stack traces and more comprehensive error messages when issues occur during data processing or output [4](https://github.com/fluent/fluent-bit/issues/920). `Trace_Output On` allows for verbose logging of output plugin operations, which can be crucial for identifying issues with data transmission to your chosen output destination [2](https://docs.fluentbit.io/manual/3.1/administration/configuring-fluent-bit/classic-mode/configuration-file).

These settings will significantly increase the amount of log data generated, so it's recommended to use them temporarily for troubleshooting purposes and revert to normal logging levels in production environments to avoid performance impacts [5](https://support.hashicorp.com/hc/en-us/articles/6150988057747-How-to-enable-the-fluent-bit-debug-logging-in-the-Terraform-Enterprise).


---
**Sources:**
- [(1) Configuration File | Fluent Bit: Official Manual](https://docs.fluentbit.io/manual/administration/configuring-fluent-bit/classic-mode/configuration-file)
- [(2) Configuration File | Fluent Bit: Official Manual](https://docs.fluentbit.io/manual/3.1/administration/configuring-fluent-bit/classic-mode/configuration-file)
- [(3) Fluent Bit Multiple Log\_Level Values - amazon eks - Stack Overflow](https://stackoverflow.com/questions/78254735/fluent-bit-multiple-log-level-values)
- [(4) config: Log\_Level setting does not take env variable · Issue #920](https://github.com/fluent/fluent-bit/issues/920)
- [(5) How to enable the fluent-bit debug logging in the Terraform Enterprise](https://support.hashicorp.com/hc/en-us/articles/6150988057747-How-to-enable-the-fluent-bit-debug-logging-in-the-Terraform-Enterprise)


## Optimizing Shard Configuration
To optimize OpenSearch cluster performance, adhere to these guidelines for shard management and resource allocation:

*   Limit total shards to 10,000 per cluster, with 25 shards or fewer per GB of JVM heap memory [1](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/bp-sharding.html).
*   Configure JVM heap size to 50% of the instance's RAM, up to 32 GiB [2](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/auto-tune.html).
*   Aim for 1.5 vCPUs per active shard as an initial scale point [3](https://aws.amazon.com/blogs/big-data/best-practices-for-configuring-your-amazon-opensearch-service-domain/).
*   Keep shard sizes between 10-30 GiB for search-heavy workloads and 30-50 GiB for write-heavy workloads [1](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/bp-sharding.html).

Exceeding these limits can lead to cluster instability and performance degradation. To reduce shard count, consider consolidating small indices, adjusting index templates, or implementing data streams for time-series data [4](https://opster.com/guides/opensearch/opensearch-capacity-planning/how-to-reduce-the-number-of-shards-in-an-opensearch-cluster/) [5](https://dev.to/viktorardelean/unleashing-opensearch-best-practices-for-1-billion-documents-on-aws-2gi9).


---
**Sources:**
- [(1) Choosing the number of shards - Amazon OpenSearch Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/bp-sharding.html)
- [(2) Auto-Tune for Amazon OpenSearch Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/auto-tune.html)
- [(3) Best practices for configuring your Amazon OpenSearch Service ...](https://aws.amazon.com/blogs/big-data/best-practices-for-configuring-your-amazon-opensearch-service-domain/)
- [(4) How to Reduce the Number of Shards in an OpenSearch Cluster](https://opster.com/guides/opensearch/opensearch-capacity-planning/how-to-reduce-the-number-of-shards-in-an-opensearch-cluster/)
- [(5) Unleashing OpenSearch: Best Practices for 1 Billion Documents on ...](https://dev.to/viktorardelean/unleashing-opensearch-best-practices-for-1-billion-documents-on-aws-2gi9)


## OpenSearch Performance Monitoring
Grafana provides powerful visualization capabilities for monitoring OpenSearch/Elasticsearch clusters. To effectively track cluster performance and resource usage, configure dashboards to display these key metrics:

*   Cluster health status (green, yellow, red) to quickly assess overall stability [1](https://opster.com/guides/elasticsearch/operations/elasticsearch-cluster-health/)
*   Node status, including active nodes and data nodes [1](https://opster.com/guides/elasticsearch/operations/elasticsearch-cluster-health/)
*   Indexing rate and search query performance [2](https://sematext.com/blog/top-10-elasticsearch-metrics-to-watch/)
*   JVM memory usage and garbage collection metrics [2](https://sematext.com/blog/top-10-elasticsearch-metrics-to-watch/)
*   CPU utilization per node [2](https://sematext.com/blog/top-10-elasticsearch-metrics-to-watch/)
*   Disk space usage and I/O statistics [2](https://sematext.com/blog/top-10-elasticsearch-metrics-to-watch/)
*   Network traffic, including bytes sent/received [2](https://sematext.com/blog/top-10-elasticsearch-metrics-to-watch/)
*   Query latency and response times [3](https://grafana.com/grafana/dashboards/8642-elasticsearch-monitoring-based-on-x-pack-stats/)
*   Error rates, including indexing and search errors [3](https://grafana.com/grafana/dashboards/8642-elasticsearch-monitoring-based-on-x-pack-stats/)

Utilize Grafana's templating feature to create dynamic dashboards that allow filtering by cluster, node, or index [3](https://grafana.com/grafana/dashboards/8642-elasticsearch-monitoring-based-on-x-pack-stats/). This enables drill-down capabilities for more detailed analysis. Set up alerts based on thresholds for critical metrics to proactively identify and address potential issues before they impact cluster performance [4](https://grafana.com/docs/grafana/latest/dashboards/assess-dashboard-usage/).


---
**Sources:**
- [(1) Elasticsearch Cluster Health: Interpreting & Boosting ... - Opster](https://opster.com/guides/elasticsearch/operations/elasticsearch-cluster-health/)
- [(2) Top 10 Elasticsearch Metrics to Monitor Performance - Sematext](https://sematext.com/blog/top-10-elasticsearch-metrics-to-watch/)
- [(3) Elasticsearch Monitoring based on X-Pack stats | Grafana Labs](https://grafana.com/grafana/dashboards/8642-elasticsearch-monitoring-based-on-x-pack-stats/)
- [(4) Assess dashboard usage | Grafana documentation](https://grafana.com/docs/grafana/latest/dashboards/assess-dashboard-usage/)


## Wrapping Up
Effectively managing Fluent Bit in Kubernetes environments requires ongoing monitoring and optimization. Regularly review and adjust configurations to ensure optimal performance and reliability. Implement a robust logging strategy that includes:

*   Periodic audits of Fluent Bit configurations to align with changing cluster needs [1](https://github.com/fluent/fluent-bit/issues/2868)
*   Utilizing debug versions of Fluent Bit containers for in-depth troubleshooting when necessary [2](https://kube-logging.dev/docs/operation/troubleshooting/fluentbit/)
*   Implementing filesystem buffering to handle backpressure and prevent data loss during high-volume scenarios [3](https://chronosphere.io/learn/avoiding-data-loss-and-backpressure-problems-with-fluent-bit/)
*   Leveraging Fluent Bit's tap feature to generate detailed event records for message flow analysis [4](https://docs.fluentbit.io/manual/administration/troubleshooting)

By combining these practices with the previously discussed strategies for OpenSearch optimization and performance monitoring, you can create a resilient and efficient logging pipeline that scales with your Kubernetes infrastructure while maintaining data integrity and system stability.


---
**Sources:**
- [(1) Fluent-bit service fails to shutdown with open TCP connection #2868](https://github.com/fluent/fluent-bit/issues/2868)
- [(2) Troubleshooting Fluent Bit - Logging operator](https://kube-logging.dev/docs/operation/troubleshooting/fluentbit/)
- [(3) Avoiding data loss and backpressure problems with Fluent Bit](https://chronosphere.io/learn/avoiding-data-loss-and-backpressure-problems-with-fluent-bit/)
- [(4) Troubleshooting | Fluent Bit: Official Manual](https://docs.fluentbit.io/manual/administration/troubleshooting)


Exported on 21/01/2025 at 15:09:48 [from Perplexity Pages](https://www.perplexity.ai/page/tips-on-storing-our-logs-to-op-IdUE5AWESSmToDKyvhuccQ) - with [SaveMyChatbot](https://save.hugocollin.com)
