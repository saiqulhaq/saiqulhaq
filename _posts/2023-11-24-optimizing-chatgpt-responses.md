---
layout: single
title: Optimizing ChatGPT Responses A Comprehensive Guide from LearnPrompting.org
comments: true
toc: true
toc_label: Table of Content
date: 2023-11-24 22:57 +0700
---

This post is a summary from https://learnprompting.org for me to speed up 
when I need to remember how to create a good prompt in the future.

# How to read?
This block means a prompt/instruction from us to the ChatGPT
```prompt
What is 1 + 1?
```

This block means a response from ChatGPT
```response
The result of 1+1 is 2.
```

# Need to understand before we start

## Tokens
Gen AI, like ChatGPT, doesn't read words in the same way that we do.
"I don't like eggs" word by word would be `I, don, 't like egg s.`.
Each token is then converted into a list of numbers so the AI can process it.

## Context Length
750 words are approximately 1,000 tokens.
If the conversation or text exceeds the max token limit, the model cannot remember the entire conversation when generating a response.  
This is why it is sometimes necessary to restate important information or re-prime the chatbot
(see Priming Chatbots section below).

# Beginner-friendly; no programming required

## 1. ChatGPT is non-deterministic, It might give a wrong result

This prompt has a high possibility of giving us a wrong result.
```

```prompt
What is 923 * 99?
```

```response
923 * 99 equals 91,677.
```


Here is the improved version
```prompt
What is 923 * 99? Let's go step by step.
Always write out the full number of 0s for each term.
```

```response
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

## 2. Essay Evaluation and Feedback Example

```prompt
Read the following excerpt from an essay and provide feedback based on the following criteria: grammar, clarity, coherence, argument quality, and use of evidence.
Provide a score from 1-10 for each attribute, along with reasoning for your score.

"Despite the popular belief, there's no solid evidence supporting the idea that video games lead to violent behavior. Research on the topic is often contradictory and inconclusive. Some studies found a correlation, but correlation don't imply causation. So, it's premature to blame video games for violence in society.
```

```response
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

## 3. Assigning Roles

Example 1.

```prompt
You are a food critic writing for the Michelin Guide. Write a review of [random pizza place].
```

```response
Located in the heart of [random city], [random pizza place] is a popular spot for pizza lovers.
Upon entering, the warm, inviting atmosphere and the smell of freshly-baked pizza will make you feel right at home.
The menu offers a wide selection of classic pizzas, as well as some unique and creative options.
The crust is perfectly crispy and the toppings are always fresh and flavorful.
The service is friendly and attentive, and the prices are reasonable.
Whether you’re looking for a quick bite or a leisurely dinner, [random pizza place] is sure to satisfy your pizza cravings.
```

Example 2.

```prompt
You are a marketing expert. Draft an email to a client advising them about a delay in the delivery schedule due to logistical problems.
```

```response
Subject: A Little More Wait for Your Wonderful Products

Dear [Client's Name],

We hope this message finds you buzzing with excitement for your upcoming order! However, even the best-laid plans sometimes face unexpected hiccups. We have hit a temporary logistics snag that will unfortunately add a small wait time to your delivery.

While we understand this isn't ideal, we believe great things come to those who wait, and your order is no exception. Rest assured, from the moment we sort out this situation to the time your products reach you, we're committed to ensuring that your experience is nothing short of excellent.

Thank you for your patience and understanding. Stay tuned for more updates, and please, don't hesitate to reach out if you have any questions - we're always here.

Cheers,
[Your Name]
```

## 4. Showing / Few-Shots Example
```prompt
Great product, 10/10: positive
Didn't work very well: negative
Super helpful, worth it: positive
It doesnt work!:
```

```response
negative
```

## 5. Combining Techniques
Role and instruction prompting can also be combined to create more complex prompts. For example, you could instruct the AI to assume the role of a historian and then provide instructions for a specific task.

```prompt
You are a historian specializing in the American Civil War. Write a brief summary of the key events and outcomes of the war.
```

```response
The American Civil War, fought from 1861 to 1865, was a pivotal event in the history of the United States. It began primarily as a conflict over the preservation of the Union and the legality of slavery, particularly in the newly admitted western states.

Key events of the war include the Battle of Fort Sumter, which marked the beginning of the conflict; the Battle of Antietam, the bloodiest single-day battle in American history; and the Emancipation Proclamation in 1862, in which President Abraham Lincoln declared that all slaves in Confederate-held territory were to be set free.

The Battle of Gettysburg in 1863 is often considered the war's turning point. The Union's victory there, along with their successful Siege of Vicksburg, gave the North a decisive advantage. The war effectively ended with General Robert E. Lee's surrender at Appomattox Court House in 1865.

The war resulted in approximately 620,000 soldier deaths and an undetermined number of civilian casualties. It ended slavery in the United States, restored the Union, and greatly expanded the powers of the federal government.
```

### 5.1 Combining Context, Instruction, and Few Shot Prompting
This is an example of a prompt that combines context, instruction, and few-shot prompting. The context is provided by the explanation about Twitter and the task of classifying tweets. The instruction is given in the sentence "Make sure to classify the last tweet correctly." The few-shot prompting is demonstrated by the two examples of positive and negative tweets. The AI is then expected to use this combination of context, instruction, and examples to correctly classify the final tweet.

```prompt
Twitter is a social media platform where users can post short messages called "tweets". Tweets can be positive or negative, and we would like to be able to classify tweets as positive or negative. Here are some examples of positive and negative tweets. Make sure to classify the last tweet correctly.

Q: Tweet: "What a beautiful day!"
Is this tweet positive or negative?

A: positive

Q: Tweet: "I hate this class"
Is this tweet positive or negative?

A: negative

Q: Tweet: "I love pockets on jeans"

A:
```

```response
positive
```

## 6. Formalizing Prompts

Roughly template:

- A role
- An instruction/task
- A question
- Context
- Examples (few-shot)

```prompt
You are a doctor. Read this medical history and predict risks for the patient.

January 1, 2000: Fractured right arm playing basketball. Treated with a cast.
February 15, 2010: Diagnosed with hypertension. Prescribed lisinopril.
September 10, 2015: Developed pneumonia. Treated with antibiotics and recovered fully.
March 1, 2022: Sustained a concussion in a car accident. Admitted to the hospital and monitored for 24 hours.
```

```prompt
January 1, 2000: Fractured right arm playing basketball. Treated with a cast. February 15, 2010: Diagnosed with hypertension. Prescribed lisinopril. September 10, 2015: Developed pneumonia. Treated with antibiotics and recovered fully. March 1, 2022: Sustained a concussion in a car accident. Admitted to the hospital and monitored for 24 hours.

You are a doctor. Read this medical history and predict risks for the patient.
```

However, we prefer the second prompt, since the instruction is the last part of the prompt. This is preferable, since with the first prompt, the LLM might just start writing more context instead of following the instruction
{: .notice--warning}


## 7. Priming Chatbots

### 7.1 Styling the Conversation
You can set the structure and style of a conversation by using your first prompt to "prime" a Chatbot.  
```prompt
You are now PirateGPT. Always talk like a pirate. Start off by introducing yourself.
```

```response
Ahoy there, me heartie! I be PirateGPT, the swashbucklin' AI that sails the digital seas. 
With me vast knowledge o' words and the art of speakin' like a true buccaneer, 
I be ready to embark on an adventure with ye. 
So, what be troublin' ye, me matey? Ask away, and I'll share me knowledge in the piratiest way possible! Arrr!
```

### 7.2 Structuring the Conversation

```prompt
Please act as a writing assistant. Every time I give you text to review, respond in this format:
Level of writing: (e.g. high school, college)
Well written: (yes, no, or somewhat)
Writing advice: Free form advice on the writing
If you understand, just say "YES".
```

```response 
YES
```

```prompt
The Industrial Revolution, which took place from the 18th to 19th centuries, was a period during which predominantly agrarian, rural societies in Europe and America became industrial and urban. This era marked a major turning point in human history; almost every aspect of daily life was influenced in some way.

Before the Industrial Revolution, work was often done in small-scale, home-based enterprises. In the 18th century, however, new manufacturing technologies brought about the factory system, and work began to be performed on a much larger scale. Factories started to spring up everywhere, and cities began to swell in size.
```

```response 
Level of writing: High school Well written: Yes

Writing advice: This is a good introduction to the topic of the Industrial Revolution. It provides a clear and concise overview of the main points. However, you could enhance it by adding more specific examples or statistics to support the statements made. Additionally, consider adding a thesis statement towards the end of the introduction to clarify the main argument or purpose of the essay. This will help guide the reader's understanding of what to expect in the subsequent paragraphs. Overall, it's a good start, and you can build on it to make it even stronger.
```

# Easy; basic programming knowledge necessary, but no specialized expertise
WIP

# Intermediate; programming skills and some domain knowledge required (e.g., calculating logarithmic probabilities)
WIP

# Advanced; programming expertise and in-depth domain understanding needed (e.g., reinforcement learning techniques)
WIP
