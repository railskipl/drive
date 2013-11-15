class AddBodyToCarprofiles < ActiveRecord::Migration
  def change
    add_column :carprofiles, :body_index_id, :integer
  end
end
