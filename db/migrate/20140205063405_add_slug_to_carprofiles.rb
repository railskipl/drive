class AddSlugToCarprofiles < ActiveRecord::Migration
  def change
    add_column :carprofiles, :slug, :string

    add_index :carprofiles, :slug
  end
end
