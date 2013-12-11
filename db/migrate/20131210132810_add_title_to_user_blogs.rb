class AddTitleToUserBlogs < ActiveRecord::Migration
  def change
    add_column :user_blogs, :title, :string
  end
end
