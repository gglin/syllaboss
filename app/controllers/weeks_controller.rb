class WeeksController < ApplicationController
  # GET /weeks
  # GET /weeks.json
  def index
    @weeks = SchoolDay.select("week").map(&:week).sort.uniq

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @weeks }
    end
  end

  # GET /weeks/1
  # GET /weeks/1.json
  def show
    @week = SchoolDay.where("week = ?", params[:id])

    @first_day_of_week = @week.sort_by(&:calendar_date).first.calendar_date.beginning_of_week
    @last_day_of_week  = @week.sort_by(&:calendar_date).first.calendar_date.end_of_week

    @prev_week = SchoolDay.where("week = ?", params[:id].to_i - 1)
    @next_week = SchoolDay.where("week = ?", params[:id].to_i + 1)
    @prev_week_id = params[:id].to_i - 1 unless @prev_week.empty?
    @next_week_id = params[:id].to_i + 1 unless @next_week.empty?

    respond_to do |format|
      format.html # show.html.erb
      format.json {  }
    end
  end

end
