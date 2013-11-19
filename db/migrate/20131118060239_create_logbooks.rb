class CreateLogbooks < ActiveRecord::Migration
  def change
    create_table :logbooks do |t|
      t.integer :user_id
      t.integer :logbook_category_id
      t.integer :car_make_id
      t.integer :car_model_id
      t.integer :body_index_id
      t.text :logbook_discription

      t.timestamps
    end
  end
end
