class AddCarNickNameToCarprofiles < ActiveRecord::Migration
  def change
    add_column :carprofiles, :car_nickname, :string
  end
end
