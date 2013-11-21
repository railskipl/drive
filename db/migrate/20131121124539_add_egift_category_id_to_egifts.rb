class AddEgiftCategoryIdToEgifts < ActiveRecord::Migration
  def change
    add_column :egifts, :egift_category_id, :integer
  end
end
