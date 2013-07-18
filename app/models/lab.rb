class Lab < ActiveRecord::Base
  include Formattable
  attr_accessible :lab_url, :name, :school_day_ids

  has_many :school_day_labs
  has_many :school_days, :through => :school_day_labs
end
