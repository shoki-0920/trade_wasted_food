class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
