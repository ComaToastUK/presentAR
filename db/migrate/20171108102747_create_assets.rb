class CreateAssets < ActiveRecord::Migration[5.1]
  def change
    create_table :assets, &:timestamps
  end
end
