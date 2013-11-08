class CreateLogbookCategories < ActiveRecord::Migration
  def change
    create_table :logbook_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
