class Lab < ActiveRecord::Base
  include Formattable
  acts_as_readable :on => :created_at
  
  attr_accessible :lab_url, :name, :school_day_ids, :comment_ids

  has_many :school_day_labs
  has_many :school_days, :through => :school_day_labs

  has_many :comments, as: :commentable, :dependent => :destroy

  validates :name, :presence => true
  validates :lab_url, :presence => true

  searchable do
    text :name, :lab_url  
  end

  def print_name
  	name
  end

  def print_search
    [name, lab_url]
  end
end
