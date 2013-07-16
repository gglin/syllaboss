class SchoolDay < ActiveRecord::Base
  belongs_to :potd
  attr_accessible :calendar_date, :ordinal, :schedule, :week
end
