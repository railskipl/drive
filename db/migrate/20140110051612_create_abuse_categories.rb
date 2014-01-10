class CreateAbuseCategories < ActiveRecord::Migration
  def change
    create_table :abuse_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
