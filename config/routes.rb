Rails.application.routes.draw do
  # 既存のUPパス（/up）を維持
  get "up" => "health#show"

  # 新しく自分で作成した HealthController の /health パスを追加
  get "health" => "health#show"
  resources :users, only: [:edit, :update]
  resource :profile, only: [:edit, :update]  # プロフィール編集ページ
  # Auth0コントローラーのルート
  get "/auth/auth0/callback", to: "auth0#callback"
  get "/auth/failure", to: "auth0#failure"
  get "/auth/logout", to: "auth0#logout"
  get "/dashboard", to: "dashboard#show"

  root to: "home#index"
end