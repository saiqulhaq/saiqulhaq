---
layout: single
title:  Handling Race Conditions in Rails
date: 2023-06-18 09:31 +0700
comments: true
categories:
  - Rails
  - Database
tags:
  - Ruby on Rails
  - Race Conditions
  - find_or_create_by
  - create_or_find_by
header:
  image: /assets/images/rails_race_conditions.jpg
---

When developing web applications using Ruby on Rails, you'll often encounter situations where you need to either find a record in your database or create a new one if it doesn't already exist. Rails provides two methods for this: `find_or_create_by` and `create_or_find_by`. However, understanding how to use them effectively involves understanding race conditions and database-level constraints.

## Race Conditions: A Primer

A race condition occurs when two or more threads can access shared data and try to change it simultaneously. In the context of a Rails application, this can happen when multiple threads or processes are trying to read from or write to your database simultaneously. This can lead to unpredictable results and hard-to-debug errors.

## Database Level Constraints

Database-level constraints are rules in your database schema that prevent invalid data from entering tables. For example, you might have a constraint that requires the email addresses of all users in your application to be unique. In a Rails migration, you can set this up like so:

```ruby
class AddIndexToUsers < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :email, unique: true
  end
end
```

This migration adds an index to the email column of the users table and specifies that the values must be unique.
find_or_create_by

The find_or_create_by method works by first trying to find a record with the specified attributes. If it can't find a match, it attempts to create a new record with those attributes.

However, this method is not atomic, meaning that it doesn't execute all at once. There's a gap between the "find" and the "create" where another process could potentially create a record, leading to race conditions. To combat this, Rails 6.0 introduced a new method.
create_or_find_by

The create_or_find_by method works the other way around. It first tries to create a record with the specified attributes. If a database-level constraint is violated (for instance, if another record with the same unique attribute already exists), it catches the resulting error and tries to find the existing record instead. This strategy minimizes the risk of race conditions, making it a safer choice when creating records in a multi-threaded environment.

However, there's a trade-off. create_or_find_by is more efficient when the record is not likely to exist already because it avoids one potentially unnecessary database read. But if the record is expected to exist, the attempted write operation can be more costly than a read.
Conclusion

Both find_or_create_by and create_or_find_by have their uses, and the choice between them will depend on your specific use case. Understanding how they work and when to use each can help you write more robust and efficient Rails applications.
