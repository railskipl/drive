class AddAttachmentImageToEgifts < ActiveRecord::Migration
  def self.up
    change_table :egifts do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :egifts, :image
  end
end
