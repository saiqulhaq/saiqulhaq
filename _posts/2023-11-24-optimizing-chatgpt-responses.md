---
layout: single
title: Optimizing ChatGPT Responses A Comprehensive Guide from LearnPrompting.org
comments: true
toc: true
toc_label: Table of Content
date: 2023-11-24 22:57 +0700
header:
  image: /assets/images/chatgpt-prompt.jpg
categories:
  - Technology
  - Level Beginner
tags:
  - ChatGPT
  - Prompting
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

# Important To Know

## Pitfalls of LLMs

* LLMs cannot accurately cite sources. It doesn't have the ability to remember where 
  their training data came from. As a result, they often generate sources that seem plausible but are entirely fabricated.
* LLMs can exhibit bias in their responses, often generating stereotypical or prejudiced content. 
  This is because they are trained on large datasets that may contain biased information.
* LLMs can sometimes "hallucinate" or generate false information when asked a question they do not know the answer to. 
  Instead of stating that they do not know the answer, they often generate a response that sounds confident but is incorrect.
* LLms often struggle with mathematical tasks and can provide incorrect answers. 
  This is because they are trained on large volumes of text and math may require a different approach. 
* LLMs can be manipulated or "hacked" by users to generate specific content that is inappropriate or harmful content

## Tokens
Gen AI, like ChatGPT, doesn't read words in the same way that we do.
"I don't like eggs" word by word would be `I, don, 't like egg s.`.
Each token is then converted into a list of numbers so the AI can process it.

## Context Length
750 words are approximately 1,000 tokens.
If the conversation or text exceeds the max token limit, the model cannot remember the entire conversation when generating a response.  
This is why it is sometimes necessary to restate important information or re-prime the chatbot
(see Priming Chatbots section below).

# Level Beginner-friendly; no programming required

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

## 8. Pitfalls of LLMs

Large Language Models (LLMs) are powerful tools that have revolutionized many aspects of technology, from customer service to content creation. However, like any technology, they are not without their flaws. Understanding these pitfalls is crucial for effectively using LLMs and mitigating potential issues. There are common pitfalls of LLMs, such as issues with citing sources, bias, hallucinations, math, and prompt hacking.

In ChatGPT, it uses Python code for Math calculation.

# Easy; basic programming knowledge necessary, but no specialized expertise
This section focus on solving simple, everyday problems.

## 1. Structuring Data
We can extract information from the following report by appending Generate a table containing this information: to it.

```prompt
In a recent business report presentation, the CEO of Zana Corp. 
Highlighted their remarkable growth in the past fiscal year.
She shared that the company experienced a 15% increase in revenue, 
reaching $50 million, with a 12% profit margin ($6 million in net profit). 
The report also showcased a 20% growth in their customer base, now totaling 100,000 customers. 
Additionally, the company's operating expenses went up by 10%, amounting to $10 million, 
while the employee headcount increased by 25%, resulting in a current workforce of 500 employees. 

Generate a table containing this information:
```

ChatGPT response:

| Metric | Value |
|---|---|
| Revenue | $50 million |
| Profit Margin | 12% |
| Net Profit | $6 million |
| Customer Base	| 100,000 |
| Operating Expenses | $10 million |
| Employee Headcount | 500 |
| Revenue Increase | 15% |
| Customer Increase | 20% |
| Operating Expenses Increase | 10% |
| Employee Headcount Increase | 25% |

## 2. Writing An Email

Instruction to send an email
```prompt
My Name: Mario
Boss's name: John

Write a **serious**, professional email to my boss saying that I will be out of office today since I am sick. 
Be concise:
```

```prompt
Dear Mario,

I hope you're doing well. I am writing to provide you with some updates on our company and to request your assistance in addressing an issue with the user interface (UI) of the software you have been working on.
As you know, our company has been focusing on providing a user-friendly experience to our customers, and we have identified some issues with the UI of the software. Specifically, we have received feedback from our users that they are having difficulty accessing certain features, and that the UI is not intuitive enough.
We need your help to address these issues and make improvements to the UI of the software. This may involve making changes to the layout, design, or functionality of the UI. We believe that your expertise in software development and your familiarity with the software will make you the ideal person to help us with this task.
If you need any additional resources or support to complete this task, please do not hesitate to let me know. Additionally, I would appreciate it if you could provide me with an estimated timeline for when you expect these modifications to be completed.
If you have any questions or need further clarification, please do not hesitate to contact me.
Thank you for your hard work and dedication to our company. I look forward to hearing back from you soon.

Best regards,
John

Generate a summary of this and a list of action items.
```

Another method:
```prompt
Summary: John is requesting Mario's assistance in addressing user interface issues with the software Mario has been working on. The issues involve difficulty accessing certain features and the UI not being intuitive enough. Mario's expertise in software development and familiarity with the software make him the ideal person to help with this task.

Action Items:
- Make changes to the layout, design, or functionality of the UI
- Request additional resources or support if needed
- Provide an estimated timeline for completion of modifications

Write a response email from Mario using the above email summary:
```

Here is a good YouTube video that you can read regarding how to write an email {% include video id="fezN-GtWobg" provider="youtube" %}

## 3. Blogs
AI can significantly reduce the time it takes to write a blog post.

```prompt
Write an outline for a short blog post about MySQL optimization
```

Response
```response 
### Outline for a Blog Post on MySQL Optimization

**I. Introduction**
   - Brief overview of MySQL and its importance in the database world.
   - Statement of purpose: Providing insights into optimization techniques for MySQL.

**II. Understanding the Basics of MySQL Performance**
   - Explanation of key performance metrics in MySQL (e.g., query speed, index usage).
   - Overview of common performance issues and their impact.

**III. Index Optimization**
   - The role of indexes in MySQL performance.
   - Best practices for creating and using indexes effectively.
   - Common mistakes to avoid with indexing.

**IV. Query Optimization**
   - Techniques for writing efficient SQL queries.
   - Tools for query analysis and optimization (e.g., EXPLAIN command).
   - Examples of optimizing complex queries.

**V. Server and Hardware Optimization**
   - Importance of hardware in MySQL performance.
   - Configuring MySQL settings for optimal performance.
   - Tips for server maintenance and upgrades.

**VI. Optimizing MySQL Configurations**
   - Detailed discussion on key MySQL configuration settings.
   - How to customize configurations based on specific needs.
   - Tools and resources for configuration management.

**VII. Routine Maintenance and Best Practices**
   - Importance of regular database maintenance.
   - Strategies for effective backup and recovery.
   - Best practices for database security and user management.

**VIII. Advanced Topics in MySQL Optimization**
   - Introduction to advanced optimization techniques (e.g., partitioning, replication).
   - Case studies of successful MySQL optimization.

**IX. Conclusion**
   - Recap of the main points discussed.
   - Encouragement to implement these optimization strategies.
   - Invitation for feedback and further discussion.

**X. Additional Resources**
   - Listing of helpful tools, websites, and books for further learning.
```

```prompt
That's a great outline, but a bit long. Condense it to the main points:
```

```response
### Condensed Outline for a Blog Post on MySQL Optimization

**I. Introduction**
   - Overview of MySQL's role in databases and the aim of the post: sharing key optimization strategies.

**II. Key Optimization Areas**
   - **Index Optimization:** Importance and best practices.
   - **Query Efficiency:** Techniques for writing and analyzing efficient SQL queries.
   - **Server and Hardware Considerations:** Role of hardware settings and server configurations in performance.

**III. Essential MySQL Configuration and Maintenance**
   - Configuring MySQL for optimal performance.
   - Routine database maintenance tips and best practices.

**IV. Conclusion**
   - Summary of optimization strategies.
   - Encouraging implementation and inviting feedback.
```

```prompt
Write a short blog post using this outline about mysql optimization
```

```response
### MySQL Optimization: Enhancing Database Performance

**Understanding MySQL's Role in Database Management**

MySQL stands as a pivotal tool in the database management world, known for its robustness and versatility. However, achieving peak performance requires a nuanced understanding of optimization strategies. This post delves into these strategies, providing practical insights for both novice and experienced users.

**Index Optimization: A Cornerstone of MySQL Efficiency**

The power of indexing in MySQL cannot be overstated. Proper indexing drastically reduces data retrieval times, making it a cornerstone of database optimization. Key practices include:

- **Creating Relevant Indexes:** Focus on frequently queried columns.
- **Avoiding Redundancy:** Excessive indexing can slow down data modification operations.

**Query Efficiency: Crafting and Analyzing SQL Queries**

Efficient SQL queries are vital for optimizing MySQL performance. Practices include:

- **Simplified Queries:** Break down complex queries into simpler forms.
- **Query Analysis Tools:** Utilize MySQL's EXPLAIN command to understand how queries are executed and identify bottlenecks.

**Server and Hardware Considerations**

MySQL performance is significantly influenced by server and hardware configurations. Key considerations include:

- **Appropriate Hardware Selection:** Ensure the server has sufficient memory and processing power.
- **MySQL Server Configuration:** Tune MySQL settings like buffer sizes and table types according to your specific use case.

**Routine MySQL Configuration and Maintenance**

Consistent configuration and maintenance of MySQL are essential. This includes:

- **Regular Updates:** Keep MySQL updated to benefit from the latest performance enhancements.
- **Backup and Recovery Practices:** Implement a robust backup strategy to prevent data loss.

**Conclusion: Implementing Optimization Strategies**

Implementing these MySQL optimization strategies can lead to substantial performance improvements. Regular monitoring and adjustment, along with a proactive approach to database management, ensure that MySQL runs efficiently. We invite feedback and further discussion on these practices. Share your experiences and tips in the comments!

---

**Further Learning:** For those looking to deepen their understanding, numerous online resources, tutorials, and MySQL documentation are available to explore these topics in greater detail.
```

```prompt
Perfect! Add a paragraph at the end to inform that I have MySQL optimization service as consultant
```

```response
**Expanding Your MySQL Optimization Capabilities**

In addition to the strategies discussed, it's worth noting that specialized consultation can further enhance your MySQL performance. I offer MySQL optimization services, bringing a wealth of experience and tailored solutions to your unique database challenges. Whether you're looking to optimize an existing system or set up a new one for peak performance, my consultancy services provide the expertise you need. Get in touch to discuss how we can collaborate to elevate your MySQL database efficiency to the next level.
```

## 4. Study Buddy

```prompt
Because of adaptations to xeric conditions and the presence of less derived woods in Pereskioideae, the Cactaceae is one of the most interesting families both anatomically and morphologically. 

What do less derived woods mean?
```

```response
In this context, "less derived woods" refers to the ancestral or primitive form of wood found in the early evolution of plants. These woods lack specialized structures and features that evolved later in more derived or advanced plants. In the Pereskioideae subfamily of the Cactaceae family, the wood is less derived compared to other subfamilies and is more similar to the wood found in non-cactus plants. The less derived wood in Pereskioideae is thought to be an adaptation to the more humid and less xeric environments in which these plants grow compared to other cacti.

```

```prompt
Generate 5 calculus I quiz questions for me:
```

```response
1. What is the derivative of y = x3?
2. Evaluate the indefinite integral of x3 + 5x2 + 7x + 4.
3. What is the product rule for derivatives?
4. Find the equation of the line tangent to y = x2 at the point (4, 16).
5. What is the second derivative of y = x4?
```

```prompt
3/20/2020 2:30 PM

Marketing Class Notes

- Discussed 4 P's of marketing: Product, Price, Place, Promotion
- Difference between B2C and B2B: B2C is direct consumer market, B2B is business to business
- Different types of market research: Quantitative and Qualitative, such as surveys and focus groups
- Pricing Strategies: Skimming, Penetration, Competition, and Value
- Segmentation: segmenting customer base by age, income, etc.
- 4 types of segmentation: Demographic, Geographic, Psychographic, and Behavioral
- Discussed different promotional tools: Advertising, Personal Selling, Public Relations, Direct Marketing, and Sales Promotions

Generate 5 marketing quiz questions for me based on my notes:
```

```response
1. What are the 4 P's of marketing?
2. What is the difference between B2C and B2B?
3. What are two types of market research?
4. What are 4 types of segmentation?
5. Name 5 promotional tools.
```

# Learn more
Make reading [https://learnprompting.org/docs/intro](https://learnprompting.org/docs/intro) as your new habit.  
The community keeps adding more information in the Github repository [https://github.com/trigaten/Learn_Prompting](https://github.com/trigaten/Learn_Prompting).
