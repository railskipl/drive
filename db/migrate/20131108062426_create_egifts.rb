class CreateEgifts < ActiveRecord::Migration
  def change
    create_table :egifts do |t|
      t.string :credit

      t.timestamps
    end
  end
end
