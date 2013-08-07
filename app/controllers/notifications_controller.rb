class NotificationsController < ApplicationController
  # GET /notifications
  # GET /notifications.json

  include NotificationsHelper

  def index
    load_all_unread

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @all_unread }
    end
  end

  def destroy
    material_type_list.each do |material_hash|
      material_type = material_hash[:name]
      if material_type != "school_day"
        material_type.classify.constantize.mark_as_read! :all, :for => current_user
      end
    end

    respond_to do |format|
      format.html { redirect_to :back, notice: "All notifications marked as read." }
      format.json { head :no_content }
    end
  end
end
