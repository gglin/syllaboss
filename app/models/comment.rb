class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :commentable_type, :content, :user_id
  
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  
  def print_name
  	commentable_id
  end

  searchable do
    text :commentable_type, :content  
  end
end
