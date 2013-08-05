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

  def self.get_wiki_pic(query_item)
    search_keywords = query_item.strip.gsub(/\s+/,'+')
    # url = "http://www.google.com/search?q=#{search_keywords}+site%3Aen.wikipedia.org"


    page = open "http://www.google.com/search?num=100&q=#{search_keywords}+wikipedia"
    html = Nokogiri::HTML page
    
    html2 = Nokogiri::HTML(open("http://#{html.search("cite").first.inner_text}"))

    image = "http:#{html2.css(".infobox img").attribute("src").value}"


  end
end
