class AddVisibilityToSendGifts < ActiveRecord::Migration
  def change
    add_column :send_gifts, :visibility_id, :integer
  end
end
