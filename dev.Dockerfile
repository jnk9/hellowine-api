FROM ruby:2.6.2

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get update -qq && \
    apt-get install -y nodejs

# Set working dir
RUN mkdir -p /var/www/app
WORKDIR /var/www/app

# Adding and installing gems
RUN gem update --system
COPY Gemfile* ./
RUN bundle install --jobs 20 --retry 5

# las dependencias de node (package.json + nodemodules) se instalan en tiempo de ejecucion
EXPOSE 3000
