class Attachment < ActiveRecord::Base
  belongs_to :lecture
  belongs_to :attachable, polymorphic: true

  attr_accessible :attachable_id, :attachable_type, :filename, :title

  mount_uploader :filename, FileUploader

  def filename_short
    filename.to_s.split("/").last
  end
end
