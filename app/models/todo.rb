class Todo < ActiveRecord::Base
  include Formattable

  attr_accessible :gist, :name, :school_day_ids, :comment_ids

  has_many :school_day_todos
  has_many :school_days, :through => :school_day_todos

  has_many :comments, as: :commentable, :dependent => :destroy

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
