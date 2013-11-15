class CreateBodyIndices < ActiveRecord::Migration
  def change
    create_table :body_indices do |t|
      t.integer :car_model_id
      t.string :bodyindex

      t.timestamps
    end
  end
end
