class CreateBlogComments < ActiveRecord::Migration
  def change
    create_table :blog_comments do |t|
      t.integer :user_id
      t.integer :user_blog_id
      t.text :body

      t.timestamps
    end
    add_foreign_key :blog_comments, :user_blogs
  end
end
