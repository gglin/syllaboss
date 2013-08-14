module AnnouncementsHelper

  def load_announcements
    @announcement  = Announcement.new

    if closest_day_before_today.announcements.empty?
      @show_latest = false
      @any_unread  = false
    else
      @latest_announcement = closest_day_before_today.announcements.order("updated_at DESC").limit(1).first

      # announcement box is default displayed until all announcements for day are marked as read
      if @latest_announcement.unread?(current_user) # || (Time.now - @latest_announcement.updated_at < 900)
        @show_latest = true
      else
        @show_latest = false
      end

      @any_unread = closest_day_before_today.announcements.any? do |announcement|
        announcement.unread?(current_user)
      end
    end
  end

  def mark_announcements_as_read
    # @latest_announcement.mark_as_read! :for => current_user if @latest_announcement
  end

end
