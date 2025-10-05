# frozen_string_literal: true

source 'https://rubygems.org'
# Hello! This is where you manage which Jekyll version is used to run.
# When you want to use a different version, change it below, save the
# file and run `bundle install`. Run Jekyll with `bundle exec`, like so:
#
#     bundle exec jekyll serve
#
# This will help ensure the proper Jekyll version is running.
# Happy Jekylling!
gem 'faraday-retry'
gem 'jekyll'
# If you want to use GitHub Pages, remove the "gem "jekyll"" above and
# uncomment the line below. To upgrade, run `bundle update github-pages`.
# gem "github-pages", group: :jekyll_plugins
# If you have any plugins, put them here!
group :jekyll_plugins do
  gem 'jekyll-archives'
  gem 'jekyll-asciinema'
  gem 'jekyll-bitly', github: 'saiqulhaq/jekyll-bitly'
  gem 'jekyll-compose'
  gem 'jekyll-data'
  gem 'jekyll-dotenv'
  gem 'jekyll-feed'
  gem 'jekyll-gist'
  gem 'jekyll_include_plugin'
  gem 'jekyll_picture_tag'
  # gem 'jekyll-sass-converter'
  gem 'jekyll-seo-tag'
  gem 'jekyll-tagging-related_posts'
  gem 'jekyll-target-blank'
  gem 'jekyll-twitter-plugin'
  gem 'jemoji'
  gem 'minimal-mistakes-jekyll'
end

# Windows and JRuby does not include zoneinfo files, so bundle the tzinfo-data gem
# and associated library.
platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem 'tzinfo', '>= 1', '< 3'
  gem 'tzinfo-data'
end

# Performance-booster for watching directories on Windows
gem 'wdm', '~> 0.1.1', platforms: %i[mingw x64_mingw mswin]

# Lock `http_parser.rb` gem to `v0.6.x` on JRuby builds since newer versions of the gem
# do not have a Java counterpart.
gem 'http_parser.rb' #, '~> 0.6.0', platforms: [:jruby]
gem "webrick"

# for devcontainer
gem "ruby-lsp"
