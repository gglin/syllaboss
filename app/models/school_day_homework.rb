class SchoolDayHomework < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :homework 
  belongs_to :school_day
end
