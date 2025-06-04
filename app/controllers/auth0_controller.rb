class Auth0Controller < ApplicationController
  def callback
  auth_info = request.env["omniauth.auth"]

  # raw_infoをセッションに保存
  session[:userinfo] = auth_info["extra"]["raw_info"]

  uid      = auth_info["uid"]
  provider = auth_info["provider"]
  email    = auth_info["info"]["email"]
  name     = auth_info["info"]["name"]
  avatar   = auth_info["info"]["image"]

  # ユーザーを検索 or 作成
  user = User.find_or_initialize_by(uid: uid, provider: provider)

  if user.new_record?
    # 初回ログイン時のみ、name・avatarも保存
    user.name          = name
    user.email         = email
    user.sign_in_count = 1
    user.save!         # ← いったん保存

    #保存後に ActiveStorage 経由で画像を添付　これをしないとエラー出る
    default_path = Rails.root.join("app", "assets", "images", "default_user.png")
      File.open(default_path) do |file|
        user.avatar.attach(
          io:           file,
          filename:     "default_user.png",
          content_type: "image/png"
        )
      end
    flash[:notice] = "初回ログインです。プロフィールを登録してください。"
    redirect_path = edit_profile_path
  else
    user.increment!(:sign_in_count)
    flash[:notice] = "ログインしました。"
    redirect_path = posts_path
  end

  # 毎回更新してよい情報だけ更新
  user.email = email
  user.save!

  # ユーザーをセッションに保存
  session[:user_id] = user.id

  redirect_to redirect_path
  end



  def failure
    # 認証に失敗した場合のエラーメッセージを取得
    @error_msg = request.params["message"]
  end

  def logout
    # セッションをリセット
    reset_session

    # Auth0のログアウトURLを生成
    redirect_to logout_url, allow_other_host: true
  end

  private

  # Auth0の設定（設定ファイルを利用）
  AUTH0_CONFIG = Rails.application.config_for(:auth0)

  # Auth0のログアウトURLを生成するヘルパーメソッド
  def logout_url
    request_params = {
      returnTo: root_url,
      client_id: AUTH0_CONFIG["auth0_client_id"]
    }

    URI::HTTPS.build(host: AUTH0_CONFIG["auth0_domain"], path: "/v2/logout", query: to_query(request_params)).to_s
  end

  # クエリパラメータを生成するためのヘルパーメソッド
  def to_query(hash)
    hash.map { |k, v| "#{k}=#{CGI.escape(v)}" unless v.nil? }.reject(&:nil?).join("&")
  end
end
