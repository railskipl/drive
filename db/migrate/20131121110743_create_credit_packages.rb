class CreateCreditPackages < ActiveRecord::Migration
  def change
    create_table :credit_packages do |t|
      t.string :name
      t.string :package_type

      t.timestamps
    end
  end
end
