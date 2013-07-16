class Session < ActiveRecord::Base
  attr_accessible :day_date, :day_number, :schedule, :week
end
