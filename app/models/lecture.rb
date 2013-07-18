class Lecture < ActiveRecord::Base
  attr_accessible :content, :creator, :file_upload, :title
  attr_accessible :school_day_ids   # these columns do not exist in db - only for mass assign

  has_many :school_day_lectures
  has_many :school_days, :through => :school_day_lectures
end
