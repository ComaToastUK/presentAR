class Asset < ApplicationRecord
  has_attached_file :uploaded_file,  validate_media_type: false
  validates_attachment_presence :uploaded_file
  do_not_validate_attachment_file_type :uploaded_file
end
