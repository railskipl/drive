class AddUserVisitToCarprofiles < ActiveRecord::Migration
  def change
    add_column :carprofiles, :user_visit, :integer,:default => 0
  end
end
