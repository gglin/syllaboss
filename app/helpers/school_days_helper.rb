module SchoolDaysHelper

  def redirect_date(datestring)
    date = Date.strptime(datestring, "%m/%d/%Y")
    school_day = SchoolDay.find_by_calendar_date(date)
    if school_day.nil?
      flash[:error] = "This date is not available."
      redirect_to root_url
    else
      redirect_to school_day_path(school_day.id)
    end
  end

  def closest_day_to_today
    SchoolDay.order("calendar_date DESC").where("calendar_date <= ?", Date.today).limit(1).first
  end

end
