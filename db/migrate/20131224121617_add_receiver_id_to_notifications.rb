class AddReceiverIdToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :receiver_id, :integer
  end
end
