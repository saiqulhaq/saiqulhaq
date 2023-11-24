---
layout: single
title: Better ChatGPT Prompt
comments: true
---

This post is a summary from https://learnprompting.org for me to speed up when I forget to create a good prompt in the future.
Hopefully it's useful for you too. Feel free to give any feedbacks in the comment section.

Table of Contents:
<!-- TOC tocDepth:1..2 chapterDepth:2..6 -->

- [Beginner-friendly; no programming required](#beginner-friendly-no-programming-required)
    - [1. ChatGPT is non-deterministic, It might be give a wrong result](#1-chatgpt-is-non-deterministic-it-might-be-give-a-wrong-result)
    - [2. 🟢 Essay Evaluation and Feedback Example](#2-🟢-essay-evaluation-and-feedback-example)
    - [3. 🟢 Assigning Roles](#3-🟢-assigning-roles)
- [Easy; basic programming knowledge necessary, but no specialized expertise](#easy-basic-programming-knowledge-necessary-but-no-specialized-expertise)
- [Intermediate; programming skills and some domain knowledge required (e.g., calculating logarithmic probabilities)](#intermediate-programming-skills-and-some-domain-knowledge-required-eg-calculating-logarithmic-probabilities)
- [Advanced; programming expertise and in-depth domain understanding needed (e.g., reinforcement learning techniques)](#advanced-programming-expertise-and-in-depth-domain-understanding-needed-eg-reinforcement-learning-techniques)

<!-- /TOC -->

# Beginner-friendly; no programming required

## 1. ChatGPT is non-deterministic, It might be give a wrong result

Wrong possibility is high

```markdown
What is 923 * 99?
```

```markdown
923 * 99 equals 91,677.
```


Here is the improved version
```markdown
What is 923 * 99? Let's go step by step.
Always write out the full number of 0s for each term.
```

```markdown
To multiply 923 by 99, we can break it down into smaller steps:

Step 1: Write out the full number of 0s for each term:
923 * 99 = 923 * 990

Step 2: Multiply the first term by 9:
923 * 9 = 8307

Step 3: Multiply the first term by 90 (adding one 0):
923 * 90 = 83070

Step 4: Add the results from step 2 and step 3:
8307 + 83070 = 91377

Therefore, 923 multiplied by 99 is equal to 91,377.
```

This process of refining our prompt over time is known as prompt engineering. You will never write the perfect prompt on your first try, so it is important to get good at refining your prompt.
{: .notice--warning}

## 2. 🟢 Essay Evaluation and Feedback Example

```markdown
Read the following excerpt from an essay and provide feedback based on the following criteria: grammar, clarity, coherence, argument quality, and use of evidence.
Provide a score from 1-10 for each attribute, along with reasoning for your score.

"Despite the popular belief, there's no solid evidence supporting the idea that video games lead to violent behavior. Research on the topic is often contradictory and inconclusive. Some studies found a correlation, but correlation don't imply causation. So, it's premature to blame video games for violence in society.
```

```markdown
Attribute: Grammar Score: 9 Reasoning: The essay is mostly grammatically correct, but there is a minor error - 'correlation don't imply causation' should be 'correlation doesn't imply causation'.
Attribute: Clarity
Score: 8
Reasoning: The essay is generally clear, but could provide more detail or explanation about the contradictory and inconclusive nature of the research.  Attribute: Coherence
Score: 8
Reasoning: The arguments are coherent and related, but the transition between them could be smoother.  Attribute: Argument Quality
Score: 7
Reasoning: The argument presented is logical and well-reasoned, but it could be strengthened with a clearer statement of the writer's position on the issue.
```

We can use them to evaluate a Google Form submission too.

## 3. 🟢 Assigning Roles

Example 1.

```markdown
You are a food critic writing for the Michelin Guide. Write a review of [random pizza place].
```

```markdown
Located in the heart of [random city], [random pizza place] is a popular spot for pizza lovers.
Upon entering, the warm, inviting atmosphere and the smell of freshly-baked pizza will make you feel right at home.
The menu offers a wide selection of classic pizzas, as well as some unique and creative options.
The crust is perfectly crispy and the toppings are always fresh and flavorful.
The service is friendly and attentive, and the prices are reasonable.
Whether you’re looking for a quick bite or a leisurely dinner, [random pizza place] is sure to satisfy your pizza cravings.
```

Example 2.

```markdown
You are a marketing expert. Draft an email to a client advising them about a delay in the delivery schedule due to logistical problems.
```

```markdown
Subject: A Little More Wait for Your Wonderful Products

Dear [Client's Name],

We hope this message finds you buzzing with excitement for your upcoming order! However, even the best-laid plans sometimes face unexpected hiccups. We have hit a temporary logistics snag that will unfortunately add a small wait time to your delivery.

While we understand this isn't ideal, we believe great things come to those who wait, and your order is no exception. Rest assured, from the moment we sort out this situation to the time your products reach you, we're committed to ensuring that your experience is nothing short of excellent.

Thank you for your patience and understanding. Stay tuned for more updates, and please, don't hesitate to reach out if you have any questions - we're always here.

Cheers,
[Your Name]
```

# Easy; basic programming knowledge necessary, but no specialized expertise

# Intermediate; programming skills and some domain knowledge required (e.g., calculating logarithmic probabilities)

# Advanced; programming expertise and in-depth domain understanding needed (e.g., reinforcement learning techniques)