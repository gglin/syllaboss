class Attachment < ActiveRecord::Base
  before_save :set_title_before_save

  # attr_accessor :title
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

  def set_title_before_save
    if self.title.nil? || self.title.empty? || self.title =~ /\A\s+\z/ || filename_changed?
      self.title = filename_short # 'title = ' doesnt work, need 'self.title = '
    end
  end
end
