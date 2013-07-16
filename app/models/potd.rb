class Potd < ActiveRecord::Base
  has_many :school_days
  attr_accessible :name, :presentation_url, :wikipedia

  def presentation_link
   if presentation_url[0..3] != "http"
      presentation_url.prepend("http://")
   else
      presentation_url
   end
  end

  def wikipedia_link
   if wikipedia[0..3] != "http"
      wikipedia.prepend("http://")
   else
      wikipedia
   end
  end

end
