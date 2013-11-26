class AddLogbookIdToFavourites < ActiveRecord::Migration
  def change
    add_column :favourites, :user_blog_id, :integer
    add_column :favourites, :logbook_id, :integer
  end
end
