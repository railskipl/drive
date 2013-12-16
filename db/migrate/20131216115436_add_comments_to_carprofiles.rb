class AddCommentsToCarprofiles < ActiveRecord::Migration
  def change
    add_column :carprofiles, :comments_count, :integer, :default => 0
  end
end
