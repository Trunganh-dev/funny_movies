# Use an appropriate base image that includes both Ruby and necessary tools
FROM ruby:3.0.2 AS base

# Install Node.js and Yarn
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - \
  && apt-get install -y nodejs \
  && npm install -g yarn

# Install MySQL client tools
RUN apt-get update \
  && apt-get install -y default-mysql-client \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy and install dependencies
FROM base AS dependencies

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY package.json yarn.lock ./
RUN yarn install

COPY wait-for-it.sh /usr/bin/wait-for-it.sh
RUN chmod +x /usr/bin/wait-for-it.sh

# Copy the rest of the application code
FROM dependencies AS application
COPY . .

EXPOSE 3000 3035

# Remove existing server.pid and start the Rails server
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && ./bin/webpack-dev-server & rails s -b '0.0.0.0'"]
