class AddSlugToUserBlogs < ActiveRecord::Migration
  def change
    add_column :user_blogs, :slug, :string

    add_index :user_blogs, :slug
  end
end
