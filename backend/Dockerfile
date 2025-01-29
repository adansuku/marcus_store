FROM ruby:3.2.2

WORKDIR /usr/src/app

# Install required dependencies
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev  && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN gem install bundler
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
