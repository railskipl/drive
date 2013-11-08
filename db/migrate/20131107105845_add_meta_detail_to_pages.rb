class AddMetaDetailToPages < ActiveRecord::Migration
  def change
    add_column :pages, :meta_title, :string
    add_column :pages, :meta_description, :text
    add_column :pages, :meta_keyword, :text
  end
end
