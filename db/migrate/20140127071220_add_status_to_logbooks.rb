class AddStatusToLogbooks < ActiveRecord::Migration
  def change
    add_column :logbooks, :status, :boolean, :default => false
  end
end
