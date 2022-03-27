
FROM ruby:2.7

ENV RAILS_ENV=production
#本番用の環境変数を設定

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
   && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
   && apt-get update -qq \
   && apt-get install -y nodejs yarn
WORKDIR /app
COPY ./src /app
RUN bundle config --local set path 'vendor/bundle' \
   && bundle install

COPY start.sh /start.sh
#実行権限を持たせる
RUN chmod 744 /start.sh
CMD ["sh", "/start.sh"]