class AddPhotoToCarprofiles < ActiveRecord::Migration
  def change
    add_column :carprofiles, :carprofile_photo_id, :integer
  end
end
