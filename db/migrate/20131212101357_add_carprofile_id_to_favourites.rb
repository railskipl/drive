class AddCarprofileIdToFavourites < ActiveRecord::Migration
  def change
    add_column :favourites, :carprofile_id, :integer
  end
end
