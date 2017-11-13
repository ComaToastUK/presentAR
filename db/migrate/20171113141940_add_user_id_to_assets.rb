class AddUserIdToAssets < ActiveRecord::Migration[5.1]
  def change
    add_reference :assets, :user, foreign_key: true
  end
end
