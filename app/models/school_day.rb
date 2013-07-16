class SchoolDay < ActiveRecord::Base
  attr_accessible :calendar_date, :ordinal, :schedule, :week, :links

  has_many :school_day_links
  has_many :links, :through => :school_day_links
  
  belongs_to :potd


	def paragraphize(content)
		body = content.split("\n").collect{|paragraph| "<p>#{paragraph}</p>"}.join("\n")
		body
	end

end
