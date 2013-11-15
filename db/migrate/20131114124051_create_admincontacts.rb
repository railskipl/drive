class CreateAdmincontacts < ActiveRecord::Migration
  def change
    create_table :admincontacts do |t|
      t.string :emailid
      t.string :carmake
      t.string :carmodel
      t.string :enginedis

      t.timestamps
    end
  end
end
