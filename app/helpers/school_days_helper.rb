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

  def placeholder_text
    "IPhone adipisicing nesciunt, DIY single-origin coffee esse Schlitz ea you probably haven't heard of them trust fund et Brooklyn irure blog in. 90's put a bird on it meh tote bag sint nihil. Enim cred incididunt proident, keffiyeh reprehenderit small batch. Williamsburg aute pitchfork gentrify, street art tousled yr hashtag VHS selfies freegan. Blue bottle magna Portland, vinyl culpa selvage YOLO Bushwick nesciunt. Portland craft beer placeat Neutra, cupidatat mumblecore lomo banh mi quis. Polaroid tumblr thundercats, Austin Williamsburg Truffaut DIY Marfa quinoa whatever bespoke."
  end

end
