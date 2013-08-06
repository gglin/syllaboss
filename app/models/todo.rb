class Todo < ActiveRecord::Base
  include Formattable
  acts_as_readable :on => :created_at

  attr_accessible :gist, :name, :school_day_ids, :comment_ids

  has_many :school_day_todos
  has_many :school_days, :through => :school_day_todos

  has_many :comments, as: :commentable, :dependent => :destroy

  validates :name, presence: true
  validates :gist, presence:true

  searchable do
    text :name, :gist
  end

  def print_name
  	name
  end

  def print_search
    [name, gist]
  end
end
