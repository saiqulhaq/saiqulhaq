# [Choice] Ruby version (use -bullseye variants on local arm64/Apple Silicon): 3, 3.2, 3.1, 3.0, 3-bookworm, 3.2-bookworm, 3.1-bookworm, 3-bullseye, 3.2-bullseye, 3.1-bullseye, 3.0-bullseye, 3-buster, 3.2-buster 3.1-buster, 3.0-buster
ARG VARIANT=3-alpine
FROM ruby:${VARIANT}

RUN apk add --update vips-dev git 
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN apk add --no-cache build-base && bundle install

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

# [Optional] Uncomment this line to install additional gems.
# RUN bundle install

# [Optional] Uncomment this line to install global node packages.
# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g <your-package-here>" 2>&1