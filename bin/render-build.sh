#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
# Ця команда оновить схему PostgreSQL на Render
bundle exec rails db:migrate
bundle exec rails:seed