class CreateContactadmins < ActiveRecord::Migration
  def change
    create_table :contactadmins do |t|
      t.string :subject
      t.text :message

      t.timestamps
    end
  end
end
