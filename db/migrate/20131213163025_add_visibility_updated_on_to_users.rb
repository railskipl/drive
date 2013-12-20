class AddVisibilityUpdatedOnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :visibility_updated_on, :datetime,:default =>(DateTime.now-10.days)
  end
end
