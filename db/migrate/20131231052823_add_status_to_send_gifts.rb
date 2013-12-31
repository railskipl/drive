class AddStatusToSendGifts < ActiveRecord::Migration
  def change
    add_column :send_gifts, :status, :boolean,:default => false
  end
end
