# syntax=docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.0.0
FROM ruby:$RUBY_VERSION-slim

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libsqlite3-dev nodejs yarn imagemagick git libvips pkg-config

# Set the working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the rest of the application
COPY . .

# Expose the port
EXPOSE 3000

# Start the server in development mode
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
