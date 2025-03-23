# config/initializers/redis.rb

if Rails.env.production?
  # ✅ 本番環境（Upstash）
  redis = Redis.new(
    url: ENV['UPSTASH_REDIS_URL'],     # rediss://... 形式
    password: ENV['REDIS_PASSWORD']    # Fly.io に登録した秘密
  )
else
  # ✅ 開発環境（ローカル Redis）
  redis_url = ENV['REDIS_URL'] || "redis://localhost:6379/0" # .envに設定したREDIS_URLを使う
  redis = Redis.new(
    url: redis_url    # docker-composeなどで起動するRedis
  )
end

# Redisを直接使いたい箇所で `redis` を参照する