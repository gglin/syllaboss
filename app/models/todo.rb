class Todo < ActiveRecord::Base
  include Formattable
  attr_accessible :gist, :name

  has_many :school_day_todos
  has_many :school_days, :through => :school_day_todos


end
