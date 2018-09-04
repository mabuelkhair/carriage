FROM ruby:2.3.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev curl nodejs postgresql-client libproj-dev less libgeos-dev python-software-properties
RUN mkdir /carriage
WORKDIR /carriage
ADD Gemfile /carriage/Gemfile
ADD Gemfile.lock /carriage/Gemfile.lock
RUN bundle install
ADD . /carriage
