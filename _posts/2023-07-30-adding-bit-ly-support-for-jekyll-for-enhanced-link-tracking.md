---
layout: single
title:  "Adding Bit.ly Support for Jekyll for Enhanced Link Tracking"
date:  2023-07-30
comments: true
categories:
  - Technology
  - Level General
tags:
  - Jekyll
  - Rubygem
header:
  image: /assets/images/jekyll-bitly.jpg
---

For blog owners and web developers, understanding user interaction is key to optimizing the user experience. 
One way to gain insights into user behavior is through link tracking, which records the number of clicks a particular link receives. 
Services like Bit.ly not only provide link shortening but also track the number of clicks a link receives. 
If you are using Jekyll for your blog or website, you can integrate Bit.ly's link tracking feature directly using the `jekyll-bitly` plugin.

To begin with, add the `jekyll-bitly` plugin to your Gemfile:

```ruby
group :jekyll_plugins do
  gem 'jekyll-bitly', github: 'saiqulhaq/jekyll-bitly'
end
```

Next, include your Bit.ly token and the jekyll-bitly plugin in your _config.yml:
```yaml
bitly:
  token: YOUR_BITLY_TOKEN
plugins:
  - OTHER_PLUGINS
  - jekyll-bitly
```

Replace `YOUR_BITLY_TOKEN` with your Bit.ly token, and `OTHER_PLUGINS` with any other plugins you're using.

Once you've done that, you can use the bitly filter to shorten and track your URLs:

```erb
{% raw %}
[Link text]({{ 'https://yourwebsite.com' | bitly }})
{% endraw %}
```

Replace https://yourwebsite.com with the URL you want to shorten and track, and Link text with the text you want to display for the link.

Your Bit.ly API token is available at https://app.bitly.com/settings/api/. Simply replace YOUR_BITLY_TOKEN in the _config.yml file with your Bit.ly API token.

Congratulations! You've successfully added Bit.ly support to your Jekyll site, which will allow you to track the click rates of your links, providing valuable insights into user interaction with your content.

FYI: Another way to add the token is through ENV. if `BITLY_TOKEN` is available, no need to update config.yml
