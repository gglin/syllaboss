module SchoolDaysHelper

  def most_recent_day_for_material(material)
    if material.respond_to?("school_days")
      most_recent_day = material.school_days.order("calendar_date DESC").where("calendar_date <= ?", Date.today).limit(1).first
    else
      most_recent_day = material.school_day
    end

    if most_recent_day.nil?
      most_recent_day = closest_day_to_today
    end

    most_recent_day
  end

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
    closest_day = SchoolDay.order("calendar_date DESC").where("calendar_date <= ?", Date.today).limit(1).first
    if closest_day.nil?
      closest_day = SchoolDay.order("calendar_date").limit(1).first
    end
    closest_day
  end

  def load_prev_and_next_day
    ordinals_array = SchoolDay.all.collect {|x| x.ordinal}.sort
    index_num = ordinals_array.index(@active_school_day.ordinal)
    
    @previous_school_day = SchoolDay.find_by_ordinal(ordinals_array[index_num-1]) unless index_num==0
    @next_school_day = SchoolDay.find_by_ordinal(ordinals_array[index_num+1])
  end

end
