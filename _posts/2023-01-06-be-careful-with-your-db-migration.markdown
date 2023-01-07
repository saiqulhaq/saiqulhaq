---
layout: single
title:  "Be Careful With Your Database Migration"
date:   2023-01-06 08:50:40 +0000
comments: true
categories:
  - Rails
  - Tips
tags:
  - activerecord
  - strong_migrations
---

In the early stage as a Start-Up, we do many experiments to prove our assumption to reach product market fit.
Updating database schema could be a daily or weekly task, and it should be done correctly.
Especially when we have reached product market fit, many users are using our product.

Example scenario:
We do this when deleting a column in Rails

```ruby
class RemoveColumn < ActiveRecord::Migration
 def change
  remove_column :users, :promo_code
 end
end
```

When we deploy the code into production and execute the migration command (rails db:migrate), any running servers will crash if there is a process that reads the `promo_code` column.
The safe way to do that is to deploy a new version to ignore the promo_code column.

```ruby
class User < ApplicationRecord
 self.ignored_columns = ["promo_code"]
end
```

Once the deployment is done, then delete the column.

```ruby
class RemoveSomeColumnFromUsers < ActiveRecord::Migration
 def change
  remove_column :users, :promo_code
 end
end
```

Fortunately, there is a RubyGem to prevent bad things happened. It's called [Strong Migrations](https://github.com/ankane/strong_migrations) 

