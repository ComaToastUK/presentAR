class Asset < ApplicationRecord
  validates :user_id, presence: true
  belongs_to :user
  has_attached_file :uploaded_file, validate_media_type: false
  validates_attachment_presence :uploaded_file
  do_not_validate_attachment_file_type :uploaded_file
  
  has_attached_file :image_target, validate_media_type: false
  validates_attachment_presence :image_target
  do_not_validate_attachment_file_type :image_target

  has_attached_file :model_image, validate_media_type: false
  validates_attachment_presence :model_image
  do_not_validate_attachment_file_type :model_image
end
