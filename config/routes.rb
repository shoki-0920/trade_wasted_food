Rails.application.routes.draw do
  # 既存のUPパス（/up）を維持
  get "up" => "health#show"

  # 新しく自分で作成した HealthController の /health パスを追加
  get "health" => "health#show"

  root to: "home#index"
end
