## Usage

After you have installed (see above), run `bundle exec jekyll help` and you should see:

Listed in help you will see new commands available to you:

```sh
  draft      # Creates a new draft post with the given NAME
  post       # Creates a new post with the given NAME
  publish    # Moves a draft into the _posts directory and sets the date
  unpublish  # Moves a post back into the _drafts directory
  page       # Creates a new page with the given NAME
  rename     # Moves a draft to a given NAME and sets the title
  compose    # Creates a new file with the given NAME
```

Create your new page using:

```sh
    $ bundle exec jekyll page "My New Page"
```

Create your new post using:

```sh
    $ bundle exec jekyll post "My New Post"
    # or specify a custom format for the date attribute in the yaml front matter
    $ bundle exec jekyll post "My New Post" --timestamp-format "%Y-%m-%d %H:%M:%S %z"
```

```sh
    # or by using the compose command
    $ bundle exec jekyll compose "My New Post"
```

```sh
    # or by using the compose command with post specified
    $ bundle exec jekyll compose "My New Post" --post
```

```sh
    # or by using the compose command with the posts collection specified
    $ bundle exec jekyll compose "My New Post" --collection "posts"
```

Create your new draft using:

```sh
    $ bundle exec jekyll draft "My new draft"
```

```sh
    # or by using the compose command with draft specified
    $ bundle exec jekyll compose "My new draft" --draft
```

```sh
    # or by using the compose command with the drafts collection specified
    $ bundle exec jekyll compose "My new draft" --collection "drafts"
```

Rename your draft using:

```sh
$ bundle exec jekyll rename _drafts/my-new-draft.md "My Renamed Draft"
```

```sh
# or rename it back
$ bundle exec jekyll rename _drafts/my-renamed-draft.md "My new draft"
```

Publish your draft using:

```sh
    $ bundle exec jekyll publish _drafts/my-new-draft.md
```

```sh
    # or specify a specific date on which to publish it
    $ bundle exec jekyll publish _drafts/my-new-draft.md --date 2014-01-24
    # or specify a custom format for the date attribute in the yaml front matter
    $ bundle exec jekyll publish _drafts/my-new-draft.md --timestamp-format "%Y-%m-%d %H:%M:%S %z"
```

Rename your post using:

```sh
$ bundle exec jekyll rename _posts/2014-01-24-my-new-draft.md "My New Post"
```

```sh
# or specify a specific date
$ bundle exec jekyll rename _posts/2014-01-24-my-new-post.md "My Old Post" --date "2012-03-04"
```

```sh
# or specify the current date
$ bundle exec jekyll rename _posts/2012-03-04-my-old-post.md "My New Post" --now
```

Unpublish your post using:

```sh
    $ bundle exec jekyll unpublish _posts/2014-01-24-my-new-draft.md
```

Create your new file in a collection using:

```sh
    $ bundle exec jekyll compose "My New Thing" --collection "things"
```

## Configuration

To customize the default plugin configuration edit the `jekyll_compose` section within your jekyll config file.

### auto-open new drafts or posts in your editor

```yaml
  jekyll_compose:
    auto_open: true
```

and make sure that you have `EDITOR`, `VISUAL` or `JEKYLL_EDITOR` environment variable set.
For instance if you wish to open newly created Jekyll posts and drafts in Atom editor you can add the following line in your shell configuration:
```sh
export JEKYLL_EDITOR=atom
```

`JEKYLL_EDITOR` will override default `EDITOR` or `VISUAL` value.
`VISUAL` will override default `EDITOR` value.

### Set default front matter for drafts and posts

If you wish to add default front matter to newly created posts or drafts, you can specify as many as you want under `default_front_matter` config keys, for instance:

```yaml
jekyll_compose:
  default_front_matter:
    drafts:
      description:
      image:
      category:
      tags:
    posts:
      description:
      image:
      category:
      tags:
      published: false
      sitemap: false
```

This will also auto add:
 - The creation timestamp under the `date` attribute.
 - The title attribute under the `title` attribute


For collections, you can add default front matter to newly created collection files using `default_front_matter` and the collection name as a config key, for instance for the collection `things`:

```yaml
jekyll_compose:
  default_front_matter:
    things:
      description:
      image:
      category:
      tags:
```
