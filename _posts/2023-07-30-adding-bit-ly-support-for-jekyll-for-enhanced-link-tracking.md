---
layout: single
title:  "Adding Bitly Support for Jekyll with jekyll_bitly_next - Enhanced Link Tracking"
date:  2023-07-30
last_modified_at: 2025-01-21
comments: true
categories:
  - Technology
  - Level General
tags:
  - Jekyll
  - Rubygem
  - Bitly
  - Link Tracking
header:
  image: /assets/images/jekyll-bitly.jpg
---

For blog owners and web developers, understanding user interaction is key to optimizing the user experience. 
One way to gain insights into user behavior is through link tracking, which records the number of clicks a particular link receives. 
Services like Bit.ly not only provide link shortening but also track the number of clicks a link receives. 
If you are using Jekyll for your blog or website, you can integrate Bit.ly's link tracking feature directly using the `jekyll_bitly_next` plugin - a modern, actively maintained gem that provides seamless Bitly integration.

To begin with, add the `jekyll_bitly_next` plugin to your Gemfile:

```ruby
gem 'jekyll_bitly_next'
```

Then run:

```bash
bundle install
```

Next, add the plugin to your `_config.yml`:

```yaml
plugins:
  - jekyll_bitly_next
```

**Note:** For older Jekyll versions, use `gems:` instead of `plugins:`.

## Configuration

You can configure your Bitly token using either of these methods:

### Method 1: Jekyll Config (for local development)

Add to your `_config.yml`:

```yaml
bitly:
  token: YOUR_BITLY_TOKEN
```

**⚠️ Security Warning:** Never commit your API token to public repositories. Consider using environment variables for production.

### Method 2: Environment Variable (recommended for production)

Set the `BITLY_TOKEN` environment variable:

```bash
# Linux/macOS
export BITLY_TOKEN=YOUR_BITLY_API_TOKEN_HERE
```

Replace `YOUR_BITLY_TOKEN` with your Bitly token. **Priority:** Config file settings take precedence over environment variables.

## Usage

Once configured, you can use the `bitly` filter to shorten and track your URLs:

### Basic Usage

```liquid
{% raw %}
[Link text]({{ 'https://yourwebsite.com' | bitly }})
{% endraw %}
```

### Advanced Examples

**In blog posts:**

```liquid
{% raw %}
---
layout: post
title: "My Awesome Post"
canonical_url: https://yourdomain.com/2025/10/awesome-post
---

Share this post: {{ page.canonical_url | bitly }}
{% endraw %}
```

**In layouts:**

```liquid
{% raw %}
<a href="{{ page.url | absolute_url | bitly }}" class="share-link">
  Share on Twitter
</a>
{% endraw %}
```

Replace `https://yourwebsite.com` with the URL you want to shorten and track, and `Link text` with the text you want to display for the link.

## Getting Your Bitly API Token

To obtain your Bitly API token:

1. Log in to your Bitly account
2. Navigate to [https://app.bitly.com/settings/api/](https://app.bitly.com/settings/api/)
3. Generate a new API token
4. Copy the token for use in your configuration

## Features & Benefits

The `jekyll_bitly_next` plugin offers several advantages:

- 🚀 **Simple Integration**: Easy-to-use Liquid filter
- 🔐 **Secure**: Token management via config or environment variables  
- 💾 **Performance**: Automatic caching of shortened URLs
- 🧪 **Reliable**: Fully tested and actively maintained
- 🎯 **Zero hassle**: Minimal configuration required

## Conclusion

Congratulations! You've successfully added Bitly support to your Jekyll site using the modern `jekyll_bitly_next` plugin. This will allow you to track the click rates of your links, providing valuable insights into user interaction with your content. The plugin's caching feature ensures your site remains fast while providing comprehensive link analytics.

Whether you're running a personal blog or a corporate website, link tracking is an essential tool for understanding your audience and optimizing your content strategy.
