class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.string  :subscriber_type
      t.integer :subscriber_id
      t.string  :subscribable_type
      t.integer :subscribable_id
      t.datetime :created_at
    end

    add_index :subscribers, ["subscriber_id", "subscriber_type"],:name => "sk_subscribers"
    add_index :subscribers, ["subscribable_id", "subscribable_type"],:name => "sk_subscribable"
  end
end
