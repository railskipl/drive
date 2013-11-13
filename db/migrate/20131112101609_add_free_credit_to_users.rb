class AddFreeCreditToUsers < ActiveRecord::Migration
  def change
    add_column :users, :credit, :integer,:default => 0, :null => false
    add_column :users, :freecredit, :integer,:default => 0, :null => false
    add_column :users, :buycredit, :integer,:default => 0, :null => false
  end
end
