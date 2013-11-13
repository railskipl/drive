class AddFreeCreditToCredits < ActiveRecord::Migration
  def change
    add_column :credits, :free_credit, :integer
  end
end
