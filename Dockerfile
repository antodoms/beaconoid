FROM ruby:2.4-slim
MAINTAINER antodoms(antodoms@gmail.com)

RUN apt-get update && apt-get install -qq -y --no-install-recommends git-core curl zlib1g-dev build-essential nodejs apt-utils libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev postgresql-client-common postgresql-client libpq-dev
RUN apt-get -qq -y install libmagickwand-dev imagemagick

ENV INSTALL_PATH /beaconoid

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile.lock ./

RUN bundle install --binstubs

COPY . .

RUN rake RAILS_ENV=development DATABASE_URL=postgresql://user:pass@127.0.0.1/beaonoid ACTION_CABLE_ALLOWED_REQUEST_ORIGINS=foo,bar SECRET_TOKEN=5395b86a5ba1eb25e4aaa26c0212f8ee3a84dd508794216e737f3a8b2ef64644bc4c126e4027042bae6f06c77794986d3a0b3f498d30f14413ecafc40af4210d assets:precompile

VOLUME ["$INSTALL_PATH/public"]

ADD . /beaconoid
ADD Gemfile /beaconoid/Gemfile
ADD Gemfile.lock /beaconoid/Gemfile.lock

RUN rails s -p 80
#ADD . /beaconoid

#EXPOSE 80