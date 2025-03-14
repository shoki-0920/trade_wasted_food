Rails.application.config.session_store :redis_store, 
  servers: "redis://trade_wasted_food-redis:6379/0", 
  expire_in: 90.minutes, 
  key: "_your_app_session"