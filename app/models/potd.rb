require 'nokogiri'
require 'open-uri'

class Potd < ActiveRecord::Base
  include Formattable
  acts_as_readable :on => :created_at

  attr_accessible :name, :presentation_url, :wikipedia  # these columns exist in db
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
    [name, wikipedia, presentation_url]
  end

  require 'nokogiri'
  require 'open-uri'

    def self.get_wiki_pic(query_item)
      search_keywords = query_item.strip.gsub(/\s+/,'+')

      page = open "http://www.google.com/search?num=100&q=#{search_keywords}+wikipedia"
      google_result = Nokogiri::HTML page

      found_url = google_result.search("cite").first.inner_text

      if found_url.include?("http://") || found_url.include?("https://")
        wiki = Nokogiri::HTML(open("#{google_result.search("cite").first.inner_text}"))
      else
        wiki = Nokogiri::HTML(open("http://#{google_result.search("cite").first.inner_text}")) 
      end

      unless wiki.css(".infobox img").empty?
        image = "http:#{wiki.css(".infobox img").attribute("src").value}"
      else
        page = open "http://www.google.com/search?num=100&q=#{search_keywords}+github"
        google_result = Nokogiri::HTML page
        found_url = google_result.search("cite").first.inner_text

        if found_url.include?("http://") || found_url.include?("https://")
          wiki = Nokogiri::HTML(open("#{google_result.search("cite").first.inner_text}"))
        else
          wiki = Nokogiri::HTML(open("http://#{google_result.search("cite").first.inner_text}")) 
        end
        image = "#{wiki.search("img").attribute("src").value}"

      end
    end

    def self.get_wiki_bio(query_item)
    search_keywords = query_item.strip.gsub(/\s+/,'+')

    page = open "http://www.google.com/search?num=100&q=#{search_keywords}+wikipedia"
    google_result = Nokogiri::HTML page

    found_url = google_result.search("cite").first.inner_text

    if found_url.include?("http://") || found_url.include?("https://")
      wiki = Nokogiri::HTML(open("#{google_result.search("cite").first.inner_text}"))
    else
      wiki = Nokogiri::HTML(open("http://#{google_result.search("cite").first.inner_text}")) 
    end

    if found_url.include?("wikipedia")
      bio = wiki.css("p")[0].text.strip
    else
      page = open "http://www.google.com/search?num=100&q=#{search_keywords}+github"
      google_result = Nokogiri::HTML page
      found_url = google_result.search("cite").first.inner_text
      
      if found_url.include?("http://") || found_url.include?("https://")
        wiki = Nokogiri::HTML(open("#{google_result.search("cite").first.inner_text}"))
      else
        wiki = Nokogiri::HTML(open("http://#{google_result.search("cite").first.inner_text}")) 
      end
      bio = wiki.css(".details").collect do |detail|
        detail.text.strip
      end
    end

  end
end
