class CreateEgiftCategories < ActiveRecord::Migration
  def change
    create_table :egift_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
