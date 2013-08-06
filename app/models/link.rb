class Link < ActiveRecord::Base
  include Formattable
  acts_as_readable :on => :created_at

  attr_accessible :description, :link_url, :title, :name, :school_day_ids, :comment_ids

  has_many :school_day_links
  has_many :school_days, :through => :school_day_links
  
  has_many :comments, as: :commentable, :dependent => :destroy

  validates :title, presence: true
  validates :link_url, presence:true

  searchable do
    text :link_url, :title, :description
  end

  def print_name
  	title
  end

  def print_search
    [title, link_url, description]
  end
end


