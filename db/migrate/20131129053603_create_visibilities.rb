class CreateVisibilities < ActiveRecord::Migration
  def change
    create_table :visibilities do |t|
      t.string :profile_type

      t.timestamps
    end
  end
end
