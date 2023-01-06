---
layout: single
title:  "Speed up Rails controller speed easily"
date:   2023-01-05 18:08:40 +0000
categories: rails
---

When we adding a Rails controller action, especially for `#show`. Usually it would be like this:  
{% highlight ruby %}
def show 
  post = Post.find(params[:id])
  render json: post
end
{% endhighlight %}

It would hit our database everytime there is a request to that action. So what we can do is we cache the Post model into Cachestore.

Usually I use identity_cache gem for that. It uses Memcached as a datastore. So it would be like this if using IdentityCache gem:

{% highlight ruby %}
def show 
  post = Post.fetch(params[:id])
  render json: post
end
{% endhighlight %}

Another optimization is we can add expiry tag

{% highlight ruby %}
def show 
  post = Post.fetch(params[:id])
  return unless stale?(post)

  render json: post
end
{% endhighlight %}

See more about IdentityCache at: [https://github.com/Shopify/identity_cache](https://github.com/Shopify/identity_cache)
