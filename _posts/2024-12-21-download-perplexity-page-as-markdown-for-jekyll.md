---
layout: single
title: Download Perplexity Page as Markdown For Jekyll
comments: true
toc: true
toc_sticky: true
categories:
- Technology
- Level General
tags:
- Jekyll
---

Converting Perplexity's page into markdown text for reposting on a Jekyll website or any markdown-based blog can be streamlined using a mix of CSS styling and JavaScript. This method ensures that external links are automatically formatted into superscript numbers enclosed in square brackets, resembling traditional academic citations.

By leveraging these tools, you can maintain a clean and professional appearance for references while ensuring compatibility with markdown-based platforms like Jekyll.

## Save my Chatbot Extension
"Save my Chatbot - AI Conversation Exporter" is a Chrome extension designed to simplify the process of saving conversations from various AI chatbots, including Perplexity, into markdown files [1](https://github.com/Hugo-COLLIN/SaveMyPhind-conversation-exporter) [2](https://chrome-stats.com/d/agklnagmfeooogcppjccdnoallkhgkod). This tool allows users to download their chat threads with a single click, preserving the content in a structured format ideal for offline storage, integration with note-taking apps, or sharing with others [1](https://github.com/Hugo-COLLIN/SaveMyPhind-conversation-exporter) [2](https://chrome-stats.com/d/agklnagmfeooogcppjccdnoallkhgkod).

Key features of the extension include:

* Support for multiple platforms: Claude, Perplexity, Phind, ChatGPT, and MaxAI-Google [2](https://chrome-stats.com/d/agklnagmfeooogcppjccdnoallkhgkod)
* Clean markdown formatting and structure [2](https://chrome-stats.com/d/agklnagmfeooogcppjccdnoallkhgkod)
* Retention of numbered sources in exported files [2](https://chrome-stats.com/d/agklnagmfeooogcppjccdnoallkhgkod)
* Customizable export options [2](https://chrome-stats.com/d/agklnagmfeooogcppjccdnoallkhgkod)
* Informative file headers and filenames, including date and URL [2](https://chrome-stats.com/d/agklnagmfeooogcppjccdnoallkhgkod)
* Indication of the chatbot response mode used (for Phind-Search and Perplexity) [2](https://chrome-stats.com/d/agklnagmfeooogcppjccdnoallkhgkod)

To use the extension, navigate to a supported chat page and click the extension icon. The conversation will be automatically downloaded as a formatted markdown file, ready for further processing or sharing [1](https://github.com/Hugo-COLLIN/SaveMyPhind-conversation-exporter) [2](https://chrome-stats.com/d/agklnagmfeooogcppjccdnoallkhgkod). This tool addresses the need for offline storage of AI-generated information and facilitates easy integration with knowledge management systems like Obsidian [3](https://www.reddit.com/r/perplexity_ai/comments/16n2g3d/i_made_an_extension_to_export_perplexity_threads/).


---
**Sources:**
- [(1) Hugo-COLLIN/SaveMyPhind-conversation-exporter: Save my Chatbot](https://github.com/Hugo-COLLIN/SaveMyPhind-conversation-exporter)
- [(2) Save my Chatbot - AI Conversation Exporter - Chrome-Stats](https://chrome-stats.com/d/agklnagmfeooogcppjccdnoallkhgkod)
- [(3) I made an extension to export Perplexity threads into markdown files](https://www.reddit.com/r/perplexity_ai/comments/16n2g3d/i_made_an_extension_to_export_perplexity_threads/)


## Custom Sources Plugin
To create a custom Jekyll plugin that enhances the `Sources` section's appearance, we can use Jekyll's plugin system to generate a neatly formatted bibliography. This approach will help maintain consistency and improve the readability of your references. Here's how to implement a custom plugin for this purpose:

First, create a new Ruby file in your Jekyll project's `_plugins` directory, naming it `sources_rewriter.rb`. In this file, you can use the plugin available at [this GitHub link](https://github.com/saiqulhaq/saiqulhaq/blob/master/_plugins/sources_rewriter.rb) to simplify the process. The plugin utilizes `details` and `summary` HTML tags to compactly display the `Sources` section. It processes each post on your site by identifying and rewriting the `Sources` section into collapsible details, ensuring sources are presented as an ordered list with clickable links where applicable. This method saves space while maintaining accessibility and readability.

To integrate this plugin effectively, ensure a `Sources` marker splits your post content. The plugin formats the sources into an HTML structure using the provided logic and appends the processed content to the post. Following these steps and using the script will make your `Sources` section visually appealing and functional.


---
**Sources:**
- [(1) Hugo-COLLIN/SaveMyPhind-conversation-exporter: Save my Chatbot](https://github.com/Hugo-COLLIN/SaveMyPhind-conversation-exporter)
- [(2) Save my Chatbot - AI Conversation Exporter - Chrome-Stats](https://chrome-stats.com/d/agklnagmfeooogcppjccdnoallkhgkod)
- [(3) I made an extension to export Perplexity threads into markdown files](https://www.reddit.com/r/perplexity_ai/comments/16n2g3d/i_made_an_extension_to_export_perplexity_threads/)


## Styling the references
You can use JavaScript and CSS to identify and style numeric or short-label links as footnotes. Copy the JavaScript code from [here](https://github.com/saiqulhaq/saiqulhaq/blob/master/_includes/head/custom.html) and the corresponding CSS from [here](https://github.com/saiqulhaq/saiqulhaq/blob/master/_sass/minimal-mistakes.scss). These resources provide a comprehensive solution to make reference links appear like footnotes.

JavaScript runs when the DOM is fully loaded. It selects all external links and applies the `footnote-link` class to those with numeric content or labels of 1-2 characters in length. A regular expression ensures precise targeting of footnote-style references.


---
**Sources:**
- [(1) Hugo-COLLIN/SaveMyPhind-conversation-exporter: Save my Chatbot](https://github.com/Hugo-COLLIN/SaveMyPhind-conversation-exporter)
- [(2) Save my Chatbot - AI Conversation Exporter - Chrome-Stats](https://chrome-stats.com/d/agklnagmfeooogcppjccdnoallkhgkod)
- [(3) I made an extension to export Perplexity threads into markdown files](https://www.reddit.com/r/perplexity_ai/comments/16n2g3d/i_made_an_extension_to_export_perplexity_threads/)


## See the Result
The techniques and tools discussed in the previous sections have been implemented to integrate Perplexity content seamlessly into a Jekyll-based website. Readers can see the practical application of these methods by visiting [https://saiqulhaq.id/importing-huge-mysql-database](https://saiqulhaq.id/importing-huge-mysql-database). This page demonstrates how the custom Jekyll plugin, CSS styling, and JavaScript enhancements work together to transform a Perplexity page into a polished blog post.

On this example page, you'll notice:

* The sources are neatly formatted and collapsible.
* External links appear as superscript numbers in square brackets, mimicking academic citations.
* The overall layout and design maintain consistency with the rest of the Jekyll site while preserving the valuable content from Perplexity.

This implementation showcases the effectiveness of the described techniques in creating a professional-looking, markdown-compatible blog post from Perplexity content.

Exported on 21/12/2024 at 11:37:00 [from Perplexity Pages](https://www.perplexity.ai/page/download-perplexity-page-as-ma-ZjF2aF5pRAGoca9G3k.7Pg) - with [SaveMyChatbot](https://save.hugocollin.com)
