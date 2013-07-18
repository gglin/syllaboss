class Attachment < ActiveRecord::Base
  attr_accessible :attachable_id, :attachable_type, :filename, :title
  belongs_to :attachable, polymorphic: true

  mount_uploader :filename, FileUploader
end
