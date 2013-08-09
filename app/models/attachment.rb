class Attachment < ActiveRecord::Base
  around_save :set_title_if_blank

  attr_accessible :attachable_id, :attachable_type, :filename, :title

  belongs_to :lecture
  belongs_to :attachable, polymorphic: true

  mount_uploader :filename, FileUploader

  validates :filename, :presence => true

  searchable do
    text :attachable_type, :filename, :title  
  end

  def print_name
  	title
  end

  def print_search
    [title, filename, attachable_type]
  end

  def filename_short
    filename.to_s.split("/").last
  end

  def set_title_if_blank
    if title.empty? || title.nil?
      title = filename_short
    end
  end
end
