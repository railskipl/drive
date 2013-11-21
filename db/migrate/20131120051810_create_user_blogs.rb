class CreateUserBlogs < ActiveRecord::Migration
  def change
    create_table :user_blogs do |t|
      t.integer :blog_id
      t.text :body

      t.timestamps
    end
  end
end
