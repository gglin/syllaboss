class SchoolDayLecture < ActiveRecord::Base
  attr_accessible :lecture_id, :school_day_id, :lecture
  
  belongs_to :lecture
  belongs_to :school_day
end
