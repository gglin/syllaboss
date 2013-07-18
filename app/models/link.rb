class Link < ActiveRecord::Base
  include Formattable
  attr_accessible :description, :link_url, :title, :name

  has_many :school_day_links
  has_many :school_days, :through => :school_day_links



end


