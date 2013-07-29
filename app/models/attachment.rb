class Attachment < ActiveRecord::Base
  attr_accessible :attachable_id, :attachable_type, :filename, :title

  belongs_to :lecture
  belongs_to :attachable, polymorphic: true

  mount_uploader :filename, FileUploader

  searchable do
    text :attachable_type, :filename, :title  
  end

  def print_name
  	title
  end

  def filename_short
    filename.to_s.split("/").last
  end
end
