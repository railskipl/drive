class AddUserIdToCarprofiles < ActiveRecord::Migration
  def change
    add_column :carprofiles, :user_id, :integer
  end
end
