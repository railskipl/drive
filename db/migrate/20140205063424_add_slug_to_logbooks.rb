class AddSlugToLogbooks < ActiveRecord::Migration
  def change
    add_column :logbooks, :slug, :string

    add_index :logbooks, :slug
  end
end
