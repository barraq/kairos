# Based on ruby 2.1.5
FROM ruby:2.2.1-wheezy

RUN apt-key adv --keyserver pool.sks-keyservers.net --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8

ENV PG_MAJOR 9.4
ENV PG_VERSION 9.4.1-1.pgdg70+1

RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main' $PG_MAJOR > /etc/apt/sources.list.d/pgdg.list

# Update and install dependencies
RUN apt-get update -qq \
    && apt-get install -y curl \
    && curl -sL https://deb.nodesource.com/setup | bash - \
    && apt-get install -y build-essential apt-utils libpq-dev \
                          nodejs npm \
                          postgresql-client-$PG_MAJOR=$PG_VERSION

# Install utilities
RUN npm install -g bower

# Copy Gemfile and install bundle
WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

# Setup app folders
RUN mkdir /kairos
ADD . /kairos
WORKDIR /kairos
