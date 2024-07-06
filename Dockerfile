# Use the official Ruby image from the Docker Hub
FROM ruby:3.2.3-alpine3.19

# Set environment variables
ENV RAILS_ENV=development

# Install Node.js and Yarn (for Rails asset pipeline)
RUN apk update && apk upgrade && \
    apk add --no-cache \
    build-base \
    postgresql-dev \
    nodejs \
    yarn \
    tzdata \
    bash \
    libxml2-dev \
    libxslt-dev \
    libc6-compat

# Create and set the working directory
RUN mkdir /app
WORKDIR /app

# Install bundler
RUN gem install bundler

# Install dependencies
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

# Copy the application code
COPY . /app


# Expose port 3000 to the host
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
