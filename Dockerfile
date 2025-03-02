# ベースイメージとしてRubyを使用
FROM ruby:3.2.2

# 必要な依存関係をインストール
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  postgresql-client \
  curl && \
  curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
  apt-get install -y nodejs && \
  npm install -g yarn

# Tailwind CSS のセットアップ
RUN yarn add -D tailwindcss@3.0.0 postcss autoprefixer && \
    yarn run tailwindcss init







# 作業ディレクトリを作成
WORKDIR /app

# Gemfile と Gemfile.lock をコピーして、bundle install を実行
COPY Gemfile Gemfile.lock ./
RUN bundle install

# アプリケーションコードをコンテナにコピー
COPY . .

# Railsサーバを起動
CMD ["rails", "server", "-b", "0.0.0.0"]
