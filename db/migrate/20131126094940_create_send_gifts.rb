class CreateSendGifts < ActiveRecord::Migration
  def change
    create_table :send_gifts do |t|
      t.integer :egift_id
      t.text :message
      t.integer :carprofile_id
      t.references :sender
      t.references :receiver
      t.timestamps
    end
  end
end
