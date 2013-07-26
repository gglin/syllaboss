class Potd < ActiveRecord::Base
  include Formattable
  
  attr_accessible :name, :presentation_url, :wikipedia  # these columns exist in db
  attr_accessible :school_day_ids, :comment_ids   # these columns do not exist in db - only for mass assign

  has_many :school_days

  has_many :comments, as: :commentable

  searchable do
    text :name, :wikipedia, :presentation_url
  end

  def print_name
    name
  end

  validates_uniqueness_of :name, :case_sensitive => false
  validates :name, :presence => true

  def title
    name
  end
end
