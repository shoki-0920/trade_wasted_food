# Ruby 3.2.2 の公式イメージを使用
FROM ruby:3.2.2

# 必要な依存関係をインストール
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  postgresql-client \
  curl \
  node-gyp \
  pkg-config \
  python-is-python3 \
  && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get install -y nodejs \
  && npm install -g yarn \
  && rm -rf /var/lib/apt/lists/*  # 不要なキャッシュを削除してイメージサイズを小さくする

# 作業ディレクトリを作成
WORKDIR /app

# Gemfile と Gemfile.lock をコピーして、bundle install を実行
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3
# 並列処理で高速化

# アプリケーションコードをコンテナにコピー
COPY . .

# デフォルトのエントリーポイント
ENTRYPOINT ["bash", "-c", "exec rails server -b 0.0.0.0"]

