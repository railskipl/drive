class AddPointsFieldToCreditPackages < ActiveRecord::Migration
  def change
    add_column :credit_packages, :points_field, :string
    add_column :credit_packages, :amount, :string
    add_column :credit_packages, :custom_field, :string
    add_column :credit_packages, :link, :text
  end
end
