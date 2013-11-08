class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :nickname, :string
    add_column :users, :birthday, :date
    add_column :users, :location, :string
    add_column :users, :agree, :boolean
    add_column :users, :status, :boolean
  end
end
