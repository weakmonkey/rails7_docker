FROM ruby:3.2.2

ENV ROOT="/app"

RUN apt-get update -qq && apt-get install -y nodejs yarnpkg postgresql-client
RUN ln -s /usr/bin/yarnpkg /usr/bin/yarn

# RUN mkdir ${ROOT}
WORKDIR ${ROOT}

COPY Gemfile ${ROOT}/Gemfile
COPY Gemfile.lock ${ROOT}/Gemfile.lock
RUN bundle install
COPY . ${ROOT}

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
