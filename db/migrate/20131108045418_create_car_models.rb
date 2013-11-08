class CreateCarModels < ActiveRecord::Migration
  def change
    create_table :car_models do |t|
      t.string :name
      t.integer :car_make_id
      t.string :engine_displacement

      t.timestamps
    end
  end
end
