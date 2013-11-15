class CreateCarprofilePhotos < ActiveRecord::Migration
  def change
    create_table :carprofile_photos do |t|
      t.integer :carprofile_id

      t.timestamps
    end
  end
end
