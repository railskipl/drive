class AddStatusToUserBlogs < ActiveRecord::Migration
  def change
    add_column :user_blogs, :status, :boolean, :default => false
  end
end
