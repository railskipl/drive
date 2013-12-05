class AddCommentableTypeToComments < ActiveRecord::Migration
  def change
  	rename_column :comments, :post_id, :commentable_id
    add_column :comments, :commentable_type, :string
    add_column :comments,:user_id,:integer
    add_index :comments, [:commentable_id,:user_id]
  end
end
