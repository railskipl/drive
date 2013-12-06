class AddLogbookUserIdToCommentLogbooks < ActiveRecord::Migration
  def change
    add_column :comment_logbooks, :logbook_user_id, :integer
  end
end
