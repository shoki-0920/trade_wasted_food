if Rails.env.production?
  Rails.application.config.session_store :redis_store,
    servers: {
      url: ENV.fetch("UPSTASH_REDIS_URL"),
      password: ENV.fetch("REDIS_PASSWORD", nil),
    },
    expire_after: 90.minutes,
    key: "_your_app_session"
else
  Rails.application.config.session_store :redis_store,
  servers: ENV["REDIS_URL"] || "redis://trade_wasted_food-redis:6379/0",  # 開発環境ではコンテナ名、その他では環境変数
  expire_in: 90.minutes,
  key: "_your_app_session"
end
