class AddEngineDisplacementToCarprofiles < ActiveRecord::Migration
  def change
    add_column :carprofiles, :engine_dis, :string
  end
end
