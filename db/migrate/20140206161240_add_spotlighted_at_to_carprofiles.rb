class AddSpotlightedAtToCarprofiles < ActiveRecord::Migration
  def change
    add_column :carprofiles, :spotlighted_at, :datetime, :default => DateTime.now
  end
end
