class AddEndManufactureYearToBodyIndices < ActiveRecord::Migration
  def change
    add_column :body_indices, :end_manufacturing_year, :string
  end
end
