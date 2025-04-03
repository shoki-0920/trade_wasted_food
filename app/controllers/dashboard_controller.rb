class DashboardController < ApplicationController
  include Secured # セキュアモジュールを導入

  def show
    @user = session[:userinfo]
  end
end
