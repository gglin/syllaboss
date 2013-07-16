class Link < ActiveRecord::Base
  attr_accessible :description, :link_url, :title, :name

  has_many :school_day_links
  has_many :school_days, :through => :school_day_links

  def http_link
   if link_url[0..3] != "http"
      link_url.prepend("http://")
   else
      link_url
   end
  end

end


