# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  private

  # セッションからユーザーIDを取り出して User レコードを返す
  def current_user
    return unless session[:user_id]
    @_current_user ||= User.find_by(id: session[:user_id])
  end
end
