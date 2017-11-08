class CreateAssets < ActiveRecord::Migration[5.1]
  def change
    create_table :assets do |t|

      t.timestamps
    end
  end
end
