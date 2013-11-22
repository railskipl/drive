class CreateFavourites < ActiveRecord::Migration
  def change
    create_table :favourites do |t|
      t.integer :user_id
      t.string :favourite_type
      t.integer :favourite_type_id
      t.boolean :is_read, :default => false

      t.timestamps
    end
  end
end
