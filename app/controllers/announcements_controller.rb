class AnnouncementsController < ApplicationController
  # GET /announcements
  # GET /announcements.json
  def index
    @announcements = Announcement.order("updated_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @announcements }
    end
  end

  # Mark all announcements for the day as read
  def markallread
    closest_day_before_today.announcements.each do |announcement|
      announcement.mark_as_read! :for => current_user
    end
  end

  # POST /announcements
  # POST /announcements.json
  def create
    @announcement = Announcement.new(params[:announcement])

    respond_to do |format|
      if @announcement.save
        if !request.referrer.split('/').include?("announcements")
          format.html { redirect_to :back, notice: 'Announcement was successfully posted.' }
          format.json { render json: @announcement, status: :created, location: :back }
        end
      else
        format.html { redirect_to :back, notice: 'There were errors posting the announcement.' }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /announcements/1
  # PUT /announcements/1.json
  def update
    @announcement = Announcement.find(params[:id])
    # Figure out how to reset read marks for just this announcement, for all users
    # Unread gem doesnt seem to have API to do this
    # @announcement.reset_read_marks_for_all

    respond_to do |format|
      if @announcement.update_attributes(params[:announcement])
        if !request.referrer.split('/').include?("announcements")
          format.html { redirect_to :back, notice: 'Announcement was successfully updated.' }
          format.json { head :no_content }
        end
      else
        format.html { render action: "edit" }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /announcements/1
  # DELETE /announcements/1.json
  def destroy
    @announcement = Announcement.find(params[:id])
    @announcement.destroy

    respond_to do |format|
      format.html { redirect_to announcements_url, notice: 'Announcement was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
