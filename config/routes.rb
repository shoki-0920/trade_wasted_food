Rails.application.routes.draw do
  # 既存のUPパス（/up）を維持
  get "up" => "rails/health#show", as: :rails_health_check

  # 新しく自分で作成した HealthController の /health パスを追加
  get "health" => "health#show", as: :health_check

  root to: "home#index"
end
