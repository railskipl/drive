class AddVisiblityStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :visibility_status, :boolean,:default => true
  end
end
