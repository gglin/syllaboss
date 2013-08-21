class ApplicationController < ActionController::Base
  protect_from_forgery

  include ApplicationHelper
  
  include SchoolDaysHelper
  include NotificationsHelper
  include AnnouncementsHelper
  include CommentsHelper

  before_filter :authenticate 
  before_filter :load_current_day

  before_filter :load_unread_resources
  before_filter :load_all_unread
  before_filter :load_unread_comments

  before_filter :load_announcements
  
  rescue_from CanCan::AccessDenied do |exception|
    flash.keep
    flash[:error] = "Access denied."
    redirect_to root_url
  end

  # @search = Lecture.search do
  #   fulltext params[:lectures_controller][:search]
  # end
  # @lectures = @search.results


private

  
  def load_current_day
    @active_school_day = closest_day_before_today

    load_prev_and_next_day
  end

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

  def authenticate
    redirect_to login_url if current_user.nil?
  end

  # def authorize
  #   redirect_to signup_url, alert: "unauthorized access" if current_user.nil?
  # end

  # def admin?
  # end
  
end
