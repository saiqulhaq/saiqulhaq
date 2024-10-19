---
layout: single
title: How to Create an Executable Test Case for Rails Issues
date: 2023-05-26 08:08 +0700
comments: true
categories:
  - Technology
  - Beginner
tags:
  - Rails
  - Testing
header:
  image: /assets/images/rails-test-case.jpg
---

When contributing to Ruby on Rails or reporting a bug, it's important to provide a way to reproduce the issue. This helps other developers confirm, investigate, and ultimately fix the problem. One of the best ways to do this is by providing an executable test case.

## What is an Executable Test Case?

An executable test case is a piece of code that demonstrates the problem you're experiencing. It includes the necessary setup and teardown to reproduce the issue in a consistent environment. You can then share this test case, so others can run it and see the issue for themselves.

## How to Create an Executable Test Case in Rails

To make the process of creating an executable test case easier, the Rails team has prepared several bug report templates. These templates include the boilerplate code to set up a test case against either a released version of Rails (`*_gem.rb`) or edge Rails (`*_main.rb`).

### Understanding the `gem` and `main` Templates

The distinction between the `gem` and `main` templates might be confusing for Rails beginners, so let's break it down:

-   `gem` templates are used for testing issues with the released version of Rails. If you're experiencing a problem with a Rails gem you've installed via RubyGems, you'll want to use the `gem` template.
    
-   `main` templates, on the other hand, are for testing the edge code on Rails' main branch on GitHub. If you're working directly with the Rails source code and encounter an issue, you'll use the `main` template.

Here are the templates you can use as a starting point:

-   Template for Active Record (models, database) issues: [gem](https://github.com/rails/rails/blob/main/guides/bug_report_templates/active_record_gem.rb) / [main](https://github.com/rails/rails/blob/main/guides/bug_report_templates/active_record_main.rb)
-   Template for testing Active Record (migration) issues: [gem](https://github.com/rails/rails/blob/main/guides/bug_report_templates/active_record_migrations_gem.rb) / [main](https://github.com/rails/rails/blob/main/guides/bug_report_templates/active_record_migrations_main.rb)
-   Template for Action Pack (controllers, routing) issues: [gem](https://github.com/rails/rails/blob/main/guides/bug_report_templates/action_controller_gem.rb) / [main](https://github.com/rails/rails/blob/main/guides/bug_report_templates/action_controller_main.rb)
-   Template for Active Job issues: [gem](https://github.com/rails/rails/blob/main/guides/bug_report_templates/active_job_gem.rb) / [main](https://github.com/rails/rails/blob/main/guides/bug_report_templates/active_job_main.rb)
-   Template for Active Storage issues: [gem](https://github.com/rails/rails/blob/main/guides/bug_report_templates/active_storage_gem.rb) / [main](https://github.com/rails/rails/blob/main/guides/bug_report_templates/active_storage_main.rb)
-   Template for Action Mailbox issues: [gem](https://github.com/rails/rails/blob/main/guides/bug_report_templates/action_mailbox_gem.rb) / [main](https://github.com/rails/rails/blob/main/guides/bug_report_templates/action_mailbox_main.rb)
-   Generic template for other issues: [gem](https://github.com/rails/rails/blob/main/guides/bug_report_templates/generic_gem.rb) / [main](https://github.com/rails/rails/blob/main/guides/bug_report_templates/generic_main.rb)

To use one of these templates:

1.  Copy the content of the appropriate template into a `.rb` file.
2.  Make the necessary changes to demonstrate the issue.
3.  Execute it by running `ruby the_file.rb` in your terminal.

If all goes well, you should see your test case failing, which means it's ready to share!

## Sharing Your Executable Test Case

Once you've created your test case, you can share it in several ways. You can create a [gist](https://gist.github.com/) with your test case, which allows others to easily view and run your code. Alternatively, you can paste the content of your test case directly into the issue description on the Rails GitHub repository.

As an example, I have commented on this [Rails issue](https://github.com/rails/rails/issues/47521), verifying the issue by creating an executable test case. I used the Active Record gem.rb template as a starting point, and filled it in with the details of the problem. You can see the executable test case I created [here](https://github.com/saiqulhaq/rails-issue-test-cases/blob/main/project/48291.rb).


Creating an executable test case is a vital part of the bug reporting process. It not only helps others understand the issue you're facing, but it also facilitates the process of investigating and fixing the issue. Happy coding!