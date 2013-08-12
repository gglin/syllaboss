class Comment < ActiveRecord::Base
  acts_as_readable :on => :created_at

  attr_accessible :commentable_id, :commentable_type, :content, :user_id
  
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :content, presence: true

  searchable do
    text :commentable_type, :content  
  end

  def print_name
    commentable_id
  end

  def print_search
    [commentable_id, content]
  end
end
