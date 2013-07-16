class SchoolDay < ActiveRecord::Base
  belongs_to :potd
  has_many :school_day_links
  has_many :links, :through => :school_day_links
  attr_accessible :calendar_date, :ordinal, :schedule, :week


	def paragraphize(content)
		body = content.split("\n").collect{|paragraph| "<p>#{paragraph}</p>"}.join("\n")
		body
	end

end
