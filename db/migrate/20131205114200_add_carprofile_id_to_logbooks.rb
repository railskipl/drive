class AddCarprofileIdToLogbooks < ActiveRecord::Migration
  def change
    add_column :logbooks, :carprofile_id, :integer
  end
end
