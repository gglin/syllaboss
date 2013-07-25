module SchoolDaysHelper

  def convert_date_to_id(datestring)
    date = Date.strptime(datestring, "%m/%d/%Y")
    SchoolDay.find_by_calendar_date(date)
  end

end
