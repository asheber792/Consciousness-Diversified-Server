class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #skip_before_action :verify_authenticity_token, :only => [:sign_out]

  helper_method :current_user

  def sign_in(user)
    token = SecureRandom.urlsafe_base64
    session[:session_token] = token
    user.update_attribute(:session_token, token)
  end

  def current_user
    @current_user ||= find_current_user
  end

  def find_current_user
    token = session[:session_token]
    token && User.find_by(session_token: token)
  end

  def sign_out(user)
    session.delete(:session_token)
    user.update_attribute(:session_token, nil)
  end
end
