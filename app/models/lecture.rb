class Lecture < ActiveRecord::Base
  include Formattable
  
  attr_accessible :content, :creator, :file_upload, :title
  attr_accessible :school_day_ids, :attachment_ids   # these columns do not exist in db - only for mass assign

  has_many :school_day_lectures
  has_many :school_days, :through => :school_day_lectures

  has_many :attachments, as: :attachable

  def paragraphize(content)
    return "" if content.nil?
    body = content.split("\n").collect{|paragraph| "<p>#{paragraph}</p>"}.join("\n")
    body
  end
end
