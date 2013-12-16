class AddCarprofileIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :carprofile_id, :integer
  end
end
