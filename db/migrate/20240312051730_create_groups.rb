class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.string :hashtag
      t.string :name
      t.text :details
      t.integer :capacity
      t.string :location
      t.string :payment_method

      t.timestamps
    end
  end
end
