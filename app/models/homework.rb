class Homework < ActiveRecord::Base
  include Formattable

  attr_accessible :title, :content, :school_day_ids
  
  has_many :school_day_homeworks
  has_many :school_days, :through => :school_day_homeworks
end
