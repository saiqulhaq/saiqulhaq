---
layout: single
date: 2023-07-24 14:28 +0700
title: Why You Should Use Constants Instead of String Literals in Ruby
date: 2023-07-24 11:32 +0700
comments: true
categories:
  - Technology
  - Level Beginner
tags:
  - Ruby
---

You might have encountered situations where you must represent different states or statuses in your code. For instance, you may be working on a booking system, and each booking can have a status like "confirmed," "canceled," or "arrived." When implementing such functionality, choosing the right approach to represent these statuses is essential. In this blog post, we'll discuss why using constants instead of string literals is a better practice and the benefits it brings to your code.

### The Common Approach: String Literals

One way to represent statuses in your Ruby code is by using string literals directly. Let's take an example of a method that updates the status of a booking:

```ruby
def update_status(status)
  booking.update(status: status)
end

update_status('canceled')
update_status("arrived")
```

While using string literals in this manner can work, it has some potential drawbacks, especially as your codebase grows and becomes more complex.

### The Better Approach: Constants

Instead of using string literals, a more recommended approach is to use constants to represent the statuses. Constants are variables in Ruby whose value cannot be changed once defined. Here's how you can use constants to represent the booking statuses:

```ruby
CANCELED = "canceled"
ARRIVED = "arrived"

def update_status(status)
  booking.update(status: status)
end

update_status(CANCELED)
update_status(ARRIVED)
```

#### Another example

```ruby
# Using String Literals

def update_status(status)
  if status == 'confirmed'
    # Logic to handle confirmed booking
    puts 'Booking is confirmed.'
  elsif status == 'canceled'
    # Logic to handle canceled booking
    puts 'Booking is canceled.'
  elsif status == 'arrived'
    # Logic to handle arrived booking
    puts 'Booking has arrived.'
  else
    puts 'Invalid status.'
  end
end

update_status('canceled')  # Output: Booking is canceled.
update_status('arrived')   # Output: Booking has arrived.
update_status('pending')   # Output: Invalid status.


# Using Constants

CONFIRMED = 'confirmed'
CANCELED = 'canceled'
ARRIVED = 'arrived'

def update_status(status)
  case status
  when CONFIRMED
    # Logic to handle confirmed booking
    puts 'Booking is confirmed.'
  when CANCELED
    # Logic to handle canceled booking
    puts 'Booking is canceled.'
  when ARRIVED
    # Logic to handle arrived booking
    puts 'Booking has arrived.'
  else
    puts 'Invalid status.'
  end
end

update_status(CANCELED)    # Output: Booking is canceled.
update_status(ARRIVED)     # Output: Booking has arrived.
update_status('pending')   # Output: Invalid status.
```

In the first example using string literals, we must compare the `status` parameter with each possible status string. This can become cumbersome and error-prone, especially as the number of status values grows. Additionally, if a typo or a different case is used when passing the status argument, the logic might not behave as expected.

On the other hand, in the second example, using constants, we use a `case` statement to handle different statuses. By using constants like `CANCELED` and `ARRIVED`, the code becomes more readable, and it's evident what each status represents. Additionally, constants reduce the likelihood of errors due to typos or case mismatches.

Using constants also allows us to provide meaningful names for status values. For instance, we could use `STATUS_CONFIRMED` instead of `'confirmed'`. This further enhances the readability and self-documentation of the code.

#### Benefits of Using Constants

1. **Readability and Self-Documentation:** Constants provide a clear and self-documenting way to represent specific values. When used as arguments, it's evident what each value represents. For example, using `CANCELED` instead of the string `"canceled"` makes the code more readable and understandable.

2. **Safety Against Typos:** Using constants reduces the chance of typos and misspellings. Since constants are defined once and can be reused, there's no need to manually type the exact string multiple times, decreasing the likelihood of errors.

3. **IDE Support:** Constants enable IDEs and static analysis tools to provide better support, including auto-completion and error checking. When using string literals, your IDE might be unable to suggest available options, making it harder for developers to know what values are valid for the argument.

4. **Easy Refactoring:** If you need to change the value of status, you can update the constant's value, and it will be reflected everywhere it's used in the code. This makes maintenance and refactoring much easier.

### Conclusion

As a Level Beginner programmer working with Ruby, adopting best practices early on is essential. When it comes to representing statuses or other fixed values in your code, using constants instead of string literals is a practice that enhances readability, reduces the likelihood of errors, and makes maintenance and refactoring easier. By following this approach, you'll write code that is more organized, safer, and easier to maintain as your projects evolve.