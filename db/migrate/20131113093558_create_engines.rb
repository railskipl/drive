class CreateEngines < ActiveRecord::Migration
  def change
    create_table :engines do |t|
      t.integer :car_model_id
      t.string :engine_displacement

      t.timestamps
    end
  end
end
