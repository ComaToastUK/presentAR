class AddImagesToAssets < ActiveRecord::Migration[5.1]
  def self.up
    change_table :assets do |t|
      t.attachment :model_image
      t.attachment :image_target
    end
  end

  def self.down
    remove_attachment :assets, :model_image
    remove_attachment :assets, :image_target
  end
end
