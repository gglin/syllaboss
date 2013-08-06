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
end
