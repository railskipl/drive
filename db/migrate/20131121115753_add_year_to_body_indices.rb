class AddYearToBodyIndices < ActiveRecord::Migration
  def change
    add_column :body_indices, :manufacturing_year, :string
  end
end
