class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name, null: false, limit: 50
      t.string :surname,    null: true,  limit: 50
      t.string :avatar, null: true,  limit: 255
      t.date :bdate

      # auth
      t.string :email, null: false, limit: 64, index: {unique: true}
      t.string :password_digest, limit: 255

      t.timestamps
    end

    # add_index :users, :email, unique: true
  end
end
