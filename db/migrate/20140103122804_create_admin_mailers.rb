class CreateAdminMailers < ActiveRecord::Migration
  def change
    create_table :admin_mailers do |t|
      t.string :name
      t.string :subject
      t.text :message
      t.string :email

      t.timestamps
    end
  end
end
