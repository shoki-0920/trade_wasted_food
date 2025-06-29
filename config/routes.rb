Rails.application.routes.draw do
  get "chat_rooms/show"
  # 既存のUPパス（/up）を維持
  get "up" => "health#show"

  # 新しく自分で作成した HealthController の /health パスを追加
  get "health" => "health#show"


  resources :users, only: [ :edit, :update ] do
    member do
      get :profile, to: "profiles#show", as: :profile
    end
  end
  resource :profile, only: [ :edit, :update, :show ]  # プロフィール編集ページ
  resources :posts, only: %i[index new create show edit update destroy] do
    resource :bookmark, only: %i[create destroy]

    collection do
      get :bookmarks
      post :preview  # 新規作成時のプレビュー
    end

    member do
      patch :preview  # POST → PATCH に変更
    end
  end


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
