class CreateCarprofiles < ActiveRecord::Migration
  def change
    create_table :carprofiles do |t|
      t.integer :car_make_id
      t.integer :car_model_id
      t.date :manufacturing_year
      t.date :year_of_purchase
      t.string :whatkindofcar

      t.timestamps
    end
  end
end
