# Dockerfile

# Use an official Ruby image as a base
FROM ruby:3.2.3

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set working directory
WORKDIR /app

# Install bundler and copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the rest of the app
COPY . .

# Precompile assets (for production only)
RUN RAILS_ENV=production bundle exec rake assets:precompile

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]

