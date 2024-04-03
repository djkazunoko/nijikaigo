class AddIndexToUsers < ActiveRecord::Migration[7.1]
  def change
    add_index :users, :name, unique: true
    add_index :users, :image_url, unique: true
  end
end
