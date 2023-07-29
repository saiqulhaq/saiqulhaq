# [Choice] Ruby version (use -bullseye variants on local arm64/Apple Silicon): 3, 3.2, 3.1, 3.0, 3-bookworm, 3.2-bookworm, 3.1-bookworm, 3-bullseye, 3.2-bullseye, 3.1-bullseye, 3.0-bullseye, 3-buster, 3.2-buster 3.1-buster, 3.0-buster
ARG VARIANT=3-alpine
FROM ruby:${VARIANT}

RUN apk --no-cache add \
  zlib-dev \
  libffi-dev \
  build-base \
  libxml2-dev \
  imagemagick-dev \
  readline-dev \
  libxslt-dev \
  libffi-dev \
  yaml-dev \
  zlib-dev \
  vips-dev \
  vips-tools \
  sqlite-dev \
  cmake

RUN apk --no-cache add \
  readline \
  nodejs \
  bash \
  npm \
  yarn

RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

# [Optional] Uncomment this section to install additional OS packages.
# RUN apk add <your-package-list-here>

# [Optional] Uncomment this line to install additional gems.
# RUN gem install gem_name

# [Optional] Uncomment this line to install global node packages.
# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g <your-package-here>" 2>&1