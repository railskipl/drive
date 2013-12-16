class AddVisibilityUpdatedOnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :visibility_updated_on, :datetime,:default =>DateTime.now
  end
end
