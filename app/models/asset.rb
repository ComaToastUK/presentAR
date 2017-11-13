class Asset < ApplicationRecord
  validates :user_id, presence: true
  has_attached_file :uploaded_file, validate_media_type: false
  validates_attachment_presence :uploaded_file
  do_not_validate_attachment_file_type :uploaded_file
  belongs_to :user
end
