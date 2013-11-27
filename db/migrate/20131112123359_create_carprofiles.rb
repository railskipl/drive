class CreateCarprofiles < ActiveRecord::Migration
  def change
    create_table :carprofiles do |t|
      t.integer :car_make_id
      t.integer :car_model_id
      t.string :manufacturing_year
      t.string :year_of_purchase
      t.string :whatkindofcar

      t.timestamps
    end
  end
end
