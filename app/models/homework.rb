class Homework < ActiveRecord::Base
  attr_accessible :title, :content, :school_day_ids
  include Formattable

  has_many :school_day_homeworks
  has_many :school_days, :through => :school_day_homeworks
end
