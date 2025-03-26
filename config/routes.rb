Rails.application.routes.draw do
  # 既存のUPパス（/up）を維持
  get "up" => "health#show"

  # 新しく自分で作成した HealthController の /health パスを追加
  get "health" => "health#show"


  # Auth0コントローラーのルート
  get '/auth/auth0', to: 'auth0#login'
  get '/auth/auth0/callback', to: 'auth0#callback'
  get '/auth/failure', to: 'auth0#failure'
  get '/auth/logout', to: 'auth0#logout'

  root to: "home#index"
end
