class PassthroughController < ApplicationController
  def index
    path =  if current_user.admin?
              week_path(@active_school_day.week)
            else
              school_day_path(@active_school_day)
            end

    redirect_to path     
  end
end
