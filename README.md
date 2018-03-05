# Stacklike backend

[![CircleCI](https://circleci.com/gh/rybex/stacklike-backend/tree/master.svg?style=svg)](https://circleci.com/gh/rybex/stacklike-backend/tree/master)

## Prerequisites

Make sure you have Ruby `2.5.0` installed with the latest `bundler`:

    gem install bundler

Then, install all dependencies:

    bundle install

Then, init the google auth secrets setup with the google developers [console](console.developers.google.com):

    cp .env.example .env
    #add secrets to the .env file

Last thing is to initialize database:

    rake db:create && rake db:migrate

To start `Hanami` server you only need to:

    rails s -b localhost -p 3000

## Console:

To start an interactive console within the project, run:

    rails c

## Tests

To run tests, execute:

    rspec

## Docker

### With a dockerized database (stateles)

If you don't have `PostgreSQL` locally, you can start a `Docker` container with it:

    ./scripts/run_postgres_docker.sh

This will run in background `PostgreSQL` installed inside a `Docker` container and expose it for further use.

## Heroku

The environment is accessible as:

- `PRODUCTION`: https://stacklike-backend.herokuapp.com/
