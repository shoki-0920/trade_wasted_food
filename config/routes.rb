Rails.application.routes.draw do
  get "chat_rooms/show"
  # 既存のUPパス（/up）を維持
  get "up" => "health#show"

  # 新しく自分で作成した HealthController の /health パスを追加
  get "health" => "health#show"


  resources :users, only: [ :edit, :update ]
  resource :profile, only: [ :edit, :update ]  # プロフィール編集ページ
  resources :posts, only: [ :index, :new, :create, :show, :edit, :update, :destroy ] # 投稿管理

  get "fishing_spots/map", to: "fishing_spots#map"
  resources :fishing_spots, only: [ :index ] do
    resources :posts, only: [ :index ]
  end


  resources :chat_requests, only: [ :create ] do
    member do
      post :approve
      post :reject
    end
  end

  resources :chat_rooms, only: [ :index, :show, :destroy ] do
    resources :messages, only: [ :create ]
  end

  # Auth0コントローラーのルート
  get "/auth/auth0/callback", to: "auth0#callback"
  get "/auth/failure", to: "auth0#failure"
  get "/auth/logout", to: "auth0#logout"

  root to: "home#index"
end
