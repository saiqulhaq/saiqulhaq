---
layout: single
title: My Note of Designing Data Intensive Application Book
comments: true
date: 2024-03-28 17:44 +0700
categories:
  - Data
  - Level General
tags: Notes
---
Data is the new oil in the modern era, and understanding the intricacies of data-intensive applications is crucial for any software engineer or system architect. Martin Kleppmann's "Designing Data-Intensive Applications" is a comprehensive guide that dives deep into the core principles of building reliable, scalable, and maintainable data systems. This blog post summarizes the key concepts from the book, draws on the provided notes, and expands on them with additional insights.

## The Pillars of Data Systems: Reliability, Scalability, and Maintainability

The foundation of any robust data system rests on three pillars: reliability, scalability, and maintainability.

### Reliability
Reliability refers to the system's ability to function without issues, even when faced with adversity. This includes hardware faults, software errors, and human mistakes. Building a reliable system means anticipating and mitigating these issues through fault tolerance and rigorous testing.

### Scalability
Scalability is the system's capacity to handle growth in data volume, traffic, or complexity. A scalable system can adapt to increased loads with minimal disruption. It's essential to understand the scalability characteristics, such as load parameters and performance bottlenecks, to design a system that can grow seamlessly.

### Maintainability
Maintainability ensures that the system remains easy to understand, modify, and extend over time. This involves good practices in code clarity, simplicity, and automation. A maintainable system reduces the cost of future changes and minimizes the risk of introducing defects.

## Data Models and Query Languages

Data models and query languages are the mediums through which we interact with data. The choice of data model has profound implications for how we write our applications and how we think about the problems we solve.

### Relational Models
Relational models organize data into tables, which can be a natural way to represent data with clear relationships and structure. SQL is the predominant query language for relational databases, offering powerful ways to filter and transform data.

### Document Models
Document models, such as those used in NoSQL databases, store data in formats like JSON or XML. They are flexible and can be more intuitive for certain applications, particularly those dealing with heterogeneous data or rapidly evolving schemas.

### Graph-Based Models
Graph-based models shine when dealing with interconnected data. They allow for efficient representation and querying of relationships, which is invaluable for social networks, recommendation systems, and more.

### Columnar Storage
Columnar storage is optimized for analytical query workloads where operations are often performed on all column entries. It's particularly effective for data warehousing and business intelligence applications.

## The Internals of Storage Engines

Understanding the internals of storage engines is critical to selecting the right one for your workload.

### Optimizations for Different Workloads
Different storage engines are optimized for workloads like transactional systems or read-heavy analytical queries. Knowing each engine's strengths and weaknesses can help you choose the most appropriate one.

### Choosing the Right Engine
The correct storage engine depends on factors like data access patterns, consistency requirements, and scalability needs. It's a decision that can significantly affect the performance and reliability of your application.

## Data Encoding and Evolution

The book also compares various formats for data encoding (serialization). It examines how they fare in an environment where application requirements change and schemas must adapt over time.

### Formats for Data Encoding
Standard data encoding formats include JSON, XML, Protocol Buffers, and Avro. Each has trade-offs regarding human readability, compactness, and schema evolution support.

## Schema Evolution
As applications evolve, so do their data requirements. A data system must support schema evolution, allowing for changes to the data model without disrupting the existing application's functionality.