class SchoolDayLab < ActiveRecord::Base
  attr_accessible :lab_id, :school_day_id, :lab

  belongs_to :lab
  belongs_to :school_day
end
