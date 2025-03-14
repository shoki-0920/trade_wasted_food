# config/initializers/redis.store.rb
Rails.application.config.session_store :redis_store, servers: "redis://localhost:6379/0", expire_in: 90.minutes
