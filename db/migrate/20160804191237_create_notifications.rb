class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :recipient_id, null: false
      t.integer :actor_id, null: false
      t.datetime :read_at
      t.string :action, null: false
      t.string :notifiable_type
      t.integer :notifiable_id
      t.integer :color, default: 1, null: false
      t.integer :icon, default: 1, null: false

      t.timestamps
    end
  end
end
