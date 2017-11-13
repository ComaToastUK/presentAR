class AddNameToAssets < ActiveRecord::Migration[5.1]
  def change
    add_column :assets, :name, :string
  end
end
