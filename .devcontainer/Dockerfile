# [Choice] Ruby version (use -bullseye variants on local arm64/Apple Silicon): 3, 3.2, 3.1, 3.0, 3-bookworm, 3.2-bookworm, 3.1-bookworm, 3-bullseye, 3.2-bullseye, 3.1-bullseye, 3.0-bullseye, 3-buster, 3.2-buster 3.1-buster, 3.0-buster
ARG VARIANT=3.2
FROM ruby:${VARIANT}

RUN apt-get update && apt-get install -y \
  zlib1g-dev \
  libffi-dev \
  build-essential \
  libxml2-dev \
  libmagickwand-dev \
  libreadline-dev \
  libxslt1-dev \
  libyaml-dev \
  libvips-dev \
  libvips-tools \
  libsqlite3-dev \
  cmake \
  git

RUN apt-get update && apt-get install -y \
  libreadline-dev \
  nodejs \
  bash \
  npm \
  yarnpkg

RUN echo "gem: --no-document" > ~/.gemrc

WORKDIR /workspace
COPY Gemfile* ./

RUN bundle install

# [Optional] Uncomment this section to install additional OS packages.
# RUN apk add <your-package-list-here>

# [Optional] Uncomment this line to install additional gems.
# RUN gem install gem_name

# [Optional] Uncomment this line to install global node packages.
# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g <your-package-here>" 2>&1