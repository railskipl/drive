class CreateCommentLogbooks < ActiveRecord::Migration
  def change
    create_table :comment_logbooks do |t|
      t.integer :logbook_id
      t.text :body
      t.integer :user_id

      t.timestamps
    end
    add_foreign_key :comment_logbooks, :logbooks

  end
end
