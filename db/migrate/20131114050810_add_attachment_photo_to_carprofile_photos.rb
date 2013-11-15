class AddAttachmentPhotoToCarprofilePhotos < ActiveRecord::Migration
  def self.up
    change_table :carprofile_photos do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :carprofile_photos, :photo
  end
end
