class Auth0Controller < ApplicationController
  def callback
    # OmniAuthから返される認証情報を取得
    auth_info = request.env['omniauth.auth']

    # raw_infoをセッションに保存
    session[:userinfo] = auth_info['extra']['raw_info']

    # 認証が成功した後にリダイレクトするURLを指定
    redirect_to '/dashboard'
  end

  def failure
    # 認証に失敗した場合のエラーメッセージを取得
    @error_msg = request.params['message']
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
      client_id: AUTH0_CONFIG['auth0_client_id']
    }

    URI::HTTPS.build(host: AUTH0_CONFIG['auth0_domain'], path: '/v2/logout', query: to_query(request_params)).to_s
  end

  # クエリパラメータを生成するためのヘルパーメソッド
  def to_query(hash)
    hash.map { |k, v| "#{k}=#{CGI.escape(v)}" unless v.nil? }.reject(&:nil?).join('&')
  end
end
