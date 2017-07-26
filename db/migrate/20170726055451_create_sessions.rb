class CreateSessions < ActiveRecord::Migration[5.1]
  IPv6Length = 39
  def change
    create_table :sessions do |t|
      t.string :remember_token, null: false, limit: 255
      t.string :ip_address, null: false, limit: IPv6Length
      t.references :user, null: false, foreign_key: {on_delete: :cascade}
      # or
      # t.integer :user_id, null: false, limit: 8, index: true
      # t.foreign_key :users, column: :user_id, on_delete: :cascade

      t.timestamps
    end
  end
end
