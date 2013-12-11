class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.integer :blocker_id
      t.integer :blockable_id
      t.string :blocker_type
      t.string :blockable_type
      t.timestamps
    end
    add_index :blocks, [:blocker_id,:blockable_id,:blocker_type,:blockable_type],:name => "IUSR_BLOCK"
  end
end
