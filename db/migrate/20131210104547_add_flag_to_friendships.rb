class AddFlagToFriendships < ActiveRecord::Migration
  def change
    add_column :friendships, :flag, :string
  end
end
