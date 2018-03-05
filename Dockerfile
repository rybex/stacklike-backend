FROM ruby:2.5.0-alpine

WORKDIR /opt/stacklike-backend

COPY Gemfile* ./

RUN gem install bundler --no-ri --no-rdoc

RUN apk update && \
    apk add build-base postgresql-dev

RUN bundle install --without development test

COPY . ./

ENV PORT ${PORT:-3000}
EXPOSE $PORT

ENV RAILS_ENV production
CMD sleep 3s && \
    rake db:migrate && \
    rais server --host 0.0.0.0 -p $PORT
