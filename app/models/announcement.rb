class Announcement < ActiveRecord::Base
  acts_as_readable :on => :created_at

  attr_accessible :content, :school_day_id, :user_id

  belongs_to :school_day
  belongs_to :user

  validates :content, presence: true

  searchable do
    text :content 
  end

  def print_name
    user_id
  end

  def print_search
    [user_id, school_day_id, content]
  end
end
