FROM ruby:2.4-slim
MAINTAINER antodoms(antodoms@gmail.com)

RUN apt-get update && apt-get install -qq -y --no-install-recommends git-core curl zlib1g-dev build-essential nodejs apt-utils libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev postgresql-client-common postgresql-client libpq-dev libmagickwand-dev imagemagick

ENV INSTALL_PATH /beaconoid

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

RUN bundle exec rake RAILS_ENV=production DATABASE_URL=postgresql://user:pass@127.0.0.1/beacon_web_console_production SECRET_TOKEN=5395b86a5ba1eb25e4aaa26c0212f8ee3a84dd508794216e737f3a8b2ef64644bc4c126e4027042bae6f06c77794986d3a0b3f498d30f14413ecafc40af4210d assets:precompile

VOLUME ["$INSTALL_PATH/public"]

CMD bundle exec unicorn -c config/unicorn/staging.rb
#ADD . /beaconoid

#EXPOSE 80