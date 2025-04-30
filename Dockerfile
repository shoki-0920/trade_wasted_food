# Ruby 3.2.2 の公式イメージを使用
FROM ruby:3.2.2

ARG RUBY_VERSION=3.2.2

# 必要な依存関係をインストール
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  postgresql-client \
  curl \
  node-gyp \
  pkg-config \
  python-is-python3 \
  libjemalloc2 \
  libvips42 \
  && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get install -y nodejs \
  && npm install -g yarn \
  && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリを作成
WORKDIR /app

# Gemfile と Gemfile.lock をコピーして、bundle install を実行
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3

# Yarn install もここで実行（Tailwind使うから必要！）
COPY package.json yarn.lock ./
RUN yarn install --check-files

# アプリケーションコードをコピー
COPY . .

# **ここで assets:precompile を追加する！！**
RUN bundle exec rails assets:precompile

# デフォルトのエントリーポイント
CMD ["bin/rails", "server", "-b", "0.0.0.0"]

