class AddSpendCreditToUsers < ActiveRecord::Migration
  def change
    add_column :users, :spend_credit, :integer, :default => 0,  :null => false
  end
end
