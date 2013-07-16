class SchoolDay < ActiveRecord::Base
  belongs_to :potd
  attr_accessible :calendar_date, :ordinal, :schedule, :week


	def paragraphize(content)
		body = content.split("\n").collect{|paragraph| "<p>#{paragraph}</p>"}.join("\n")
		body
	end

end
