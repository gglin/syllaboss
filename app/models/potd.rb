require 'nokogiri'
require 'open-uri'

class Potd < ActiveRecord::Base
  include Formattable

  acts_as_readable :on => :created_at
  
  attr_accessible :name, :presentation_url, :wikipedia, :bio
    # these columns exist in db
  attr_accessible :school_day_ids, :comment_ids   # these columns do not exist in db - only for mass assign

  has_many :school_days

  has_many :comments, as: :commentable, :dependent => :destroy

  searchable do
    text :name, :wikipedia, :presentation_url
  end

  validates_uniqueness_of :name, :case_sensitive => false
  validates :name, :presence => true
  # validates :wikipedia, :presence => true

  def print_name
    name
  end

  def print_search
    bio
  end

  def self.linkify(url)
    if url.include?("http://") || url.include?("https://")
      url
    else
      "http://#{url}"
    end
  end

  def self.scrape_url(search_string, query = "wikipedia")
    begin
    
    page = open "http://www.google.com/search?num=100&q=#{search_string}+#{query}"
    rescue OpenURI::HTTPError => the_error
      page = open "http://www.bing.com/search?num=100&q=#{search_string}+#{query}"
    end
    google_result = Nokogiri::HTML page

    found_url = google_result.search("cite").first.inner_text  
  end

  require 'nokogiri'
  require 'open-uri'

  def self.scrape_pic(query_item)
    search_string = query_item.strip.gsub(/\s+/,'+')
    found_url = self.scrape_url(search_string,"wikipedia")
    
    if found_url.include?("wikipedia")
      wiki = Nokogiri::HTML(open(self.linkify(found_url))) 
      if wiki.css("p")[0].text.strip.include?("may refer to")
        wiki = Nokogiri::HTML(open(self.linkify(self.scrape_url(search_string,"wikipedia+programmer"))))
      end
      image = "#{wiki.css(".infobox img").attribute("src").value}"
    else
      found_url = self.scrape_url(search_string,"github")
      wiki = Nokogiri::HTML(open(self.linkify(found_url)))

      image = "#{wiki.search("img").attribute("src").value}"

    end
  end

  def self.scrape_bio(query_item)
    search_string = query_item.strip.gsub(/\s+/,'+')
    found_url = self.scrape_url(search_string,"wikipedia")

    if found_url.include?("wikipedia") 
      wiki = Nokogiri::HTML(open(self.linkify(found_url))) 
      if wiki.css("p")[0].text.strip.include?("may refer to")
        wiki = Nokogiri::HTML(open(self.linkify(self.scrape_url(search_string,"wikipedia+programmer"))))
      end
      bio = wiki.css("p")[0].text.strip.gsub(/\[.+]/,"")
    else
      found_url = self.scrape_url(search_string,"github")
      wiki = Nokogiri::HTML(open(self.linkify(found_url)))

      bio = wiki.css(".details").text.strip.gsub(".com",".com, ").gsub("{email}",", ").gsub(/\s{2,}/,",").gsub(", 200", " 200").strip.chomp.split(",")
      bio.collect do |piece|
        piece.strip.chomp
      end

    end

  end
end
