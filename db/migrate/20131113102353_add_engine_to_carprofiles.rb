class AddEngineToCarprofiles < ActiveRecord::Migration
  def change
    add_column :carprofiles, :engine_id, :integer
  end
end
