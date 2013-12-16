class AddUserBlogUserIdToBlogComments < ActiveRecord::Migration
  def change
    add_column :blog_comments, :user_blog_user_id, :integer
  end
end
