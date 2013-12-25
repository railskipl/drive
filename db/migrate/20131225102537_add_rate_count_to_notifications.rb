class AddRateCountToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :rate_count, :string
  end
end
