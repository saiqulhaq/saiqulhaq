# [Choice] Ruby version (use -bullseye variants on local arm64/Apple Silicon): 3, 3.2, 3.1, 3.0, 3-bookworm, 3.2-bookworm, 3.1-bookworm, 3-bullseye, 3.2-bullseye, 3.1-bullseye, 3.0-bullseye, 3-buster, 3.2-buster 3.1-buster, 3.0-buster
ARG VARIANT=3-alpine
FROM ruby:${VARIANT} as base-image
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
  cmake \
  git \
  readline \
  nodejs \
  bash \
  npm \
  yarn

FROM base-image AS gem-cache
RUN mkdir -p /usr/local/bundle 
ENV GEM_HOME="/usr/local/bundle"
ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH
RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc

FROM base-image AS base
RUN gem install bundler

FROM base AS gems
COPY --from=gem-cache /usr/local/bundle /usr/local/bundle
COPY Gemfile Gemfile.lock ./
RUN bundle install

FROM base AS deploy
COPY --from=gems /usr/local/bundle /usr/local/bundle
COPY . .

# [Optional] Uncomment this line to install global node packages.
# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g <your-package-here>" 2>&1
ENTRYPOINT ["fix_bundler.sh"]