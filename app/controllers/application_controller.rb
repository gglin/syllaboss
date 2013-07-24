class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_current_day

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

private
  
  def load_current_day
    @active_school_day = SchoolDay.first
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    redirect_to login_url, alert: "unauthorized access" if current_user.nil?
  end

  # def admin?
  # end
  
end
