class SchoolDayLink < ActiveRecord::Base
  attr_accessible :link_id, :school_day_id, :link

  belongs_to :link
  belongs_to :school_day
end
