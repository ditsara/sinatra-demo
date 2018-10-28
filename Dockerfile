FROM ruby:2.5
LABEL maintainer="Dan Itsara <dan@glazziq.com>"
RUN gem update --system && gem install bundler
ENV BUNDLE_PATH=/gems BUNDLE_BIN=/gems/bin GEM_HOME=/gems
