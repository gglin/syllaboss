class SchoolDayHomework < ActiveRecord::Base
  attr_accessible :homework_id, :school_day_id, :homework

  belongs_to :homework 
  belongs_to :school_day
end
