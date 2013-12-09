class AddTitleToLogbooks < ActiveRecord::Migration
  def change
    add_column :logbooks, :title, :string
  end
end
