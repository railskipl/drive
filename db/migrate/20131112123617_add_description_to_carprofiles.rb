class AddDescriptionToCarprofiles < ActiveRecord::Migration
  def change
    add_column :carprofiles, :car_description, :text
    add_column :carprofiles, :power, :string
    add_column :carprofiles, :sellthiscar, :string
    add_column :carprofiles, :license_plate, :string
    add_column :carprofiles, :VIN, :string
  end
end
