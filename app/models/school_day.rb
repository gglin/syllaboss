class SchoolDay < ActiveRecord::Base
  attr_accessible :calendar_date, :ordinal, :schedule, :week, :links, :potd_id, :links_attributes

  belongs_to :potd

  has_many :school_day_links
  has_many :links, :through => :school_day_links

  has_many :school_day_todos
  has_many :todos, :through => :school_day_todos
  
  # validates_uniqueness_of :ordinal, :calendar_date
  validates :ordinal, :week, :calendar_date, :presence => true

  accepts_nested_attributes_for :links

	def paragraphize(content)
		body = content.split("\n").collect{|paragraph| "<p>#{paragraph}</p>"}.join("\n")
		body
	end


end

