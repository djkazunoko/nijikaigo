class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.string :hashtag, null: false
      t.string :name, null: false
      t.text :details, null: false
      t.integer :capacity, null: false
      t.string :location, null: false
      t.string :payment_method, null: false

      t.timestamps
    end
  end
end
