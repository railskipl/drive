class AddSpotlightedToCarprofiles < ActiveRecord::Migration
  def change
    add_column :carprofiles, :spotlighted, :boolean,:default =>false
  end
end