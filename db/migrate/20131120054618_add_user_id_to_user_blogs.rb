class AddUserIdToUserBlogs < ActiveRecord::Migration
  def change
    add_column :user_blogs, :user_id, :integer
  end
end
