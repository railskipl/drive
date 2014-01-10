class CreateAbuseReports < ActiveRecord::Migration
  def change
    create_table :abuse_reports do |t|
      t.integer :user_id
      t.integer :carprofile_id
      t.integer :logbook_id
      t.integer :user_blog_id
      t.integer :comment_id
      t.string :abuse_type
      t.integer :abuser_user_id
      t.text :comments
      t.integer :abuse_category_id

      t.timestamps
    end
  end
end
