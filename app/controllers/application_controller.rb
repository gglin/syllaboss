class ApplicationController < ActionController::Base
  protect_from_forgery

  include SchoolDaysHelper
  include ApplicationHelper

  before_filter :authenticate 
  before_filter :load_current_day
  before_filter :load_unread_resources
  
  rescue_from CanCan::AccessDenied do |exception|
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
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authenticate
    redirect_to signup_url if current_user.nil?
  end

  def load_unread_resources
    @unread = []
    material_type_list.each do |material_hash|
      material_type = material_hash[:name]
      if material_type != "school_day"
        unread_materials = material_type.classify.constantize.unread_by(current_user)
        if current_user.admin?
          filtered_unread_materials = unread_materials
        else
          filtered_unread_materials = unread_materials.select do |material| 
            !material.school_days.empty? && !material.school_days.nil? && material.school_days.include?(closest_day_before_today)
          end
        end
        @unread += filtered_unread_materials
      end
    end
    @unread.sort_by!(&:updated_at).reverse!
  end


  # def authorize
  #   redirect_to signup_url, alert: "unauthorized access" if current_user.nil?
  # end

  # def admin?
  # end
  
end
