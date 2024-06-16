---
layout: single
title: common challenges to build LLM app into our app
---

some very common challenges encountered at this step:

* No matter how effective our RAG pipeline is, at the end of the day, the quality of the final result will largely depend on the quality of the initial data. 
  To overcome this challenge, make sure you start by cleaning up your data first. 
  Eliminate potential duplicates and errors. While not exactly duplicates, redundant information can also clutter your knowledge base and confuse the RAG system. 
  Be on the lookout for ambiguous, biased, incomplete, or outdated information. 
  I’ve seen many cases of poorly structured and insufficiently maintained knowledge repositories that were completely useless for users looking for quick and accurate answers. 
  Ask yourself this question: If I were to manually search through this data, how easy would it be to find the information I need? 
  Before moving on with building the pipeline, do yourself a favor and prepare your data thoroughly until you’re satisfied with the answer to that question.
* Our data is dynamic. An organizational knowledge repository is rarely a static, permanent data source.
  It evolves with the business, reflecting new insights, discoveries, and changes in the external environment.
  Recognizing this fluid nature is key to maintaining a relevant and effective system. 
  To overcome this challenge, in a production RAG application, you’ll have to implement a systematic method for periodically reviewing and updating the content, ensuring that new information is incorporated and outdated or incorrect data is removed.
* Data comes in many flavors, shapes, and sizes. Sometimes, it’s structured, sometimes not. 
  A well-built RAG system should be able to properly ingest all kinds of formats and document types.
  While LlamaIndex provides a huge number of data loaders for many different APIs, databases, and document types, building an automated ingestion system can still prove to be challenging.
  To overcome this particular challenge, later in this section, we’ll cover LlamaParse – an innovative hosted service designed to automatically ingest and process data from different data sources.
