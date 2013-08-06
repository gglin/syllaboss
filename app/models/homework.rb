class Homework < ActiveRecord::Base
  include Formattable
  acts_as_readable :on => :created_at
  # acts_as_readable :on => :updated_at

  attr_accessible :title, :content, :school_day_ids, :comment_ids
  
  has_many :school_day_homeworks
  has_many :school_days, :through => :school_day_homeworks

  has_many :comments, as: :commentable, :dependent => :destroy

  validates :title, presence: true
  validates :content, presence:true

  searchable do
    text :title, :content  
  end

  def print_name
  	title
  end

  def print_search
    [title, content]
  end
end
