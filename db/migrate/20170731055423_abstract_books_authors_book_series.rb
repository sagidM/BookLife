class AbstractBooksAuthorsBookSeries < ActiveRecord::Migration[5.1]
  def change
    create_table :abstract_books do |t|
      t.string :original_name, limit: 50, null: false, index: true
      t.date :published_at, null: false
      t.timestamps
    end

    create_table :authors do |t|
      t.string :first_name, limit: 50, null: false
      t.string :surname, limit: 50, null: false
      t.string :patronymic, limit: 50
      t.string :avatar, null: true,  limit: 255
      t.date :bdate
      t.references :user, foreign_key: {on_delete: :cascade}, index: false
      t.index [:first_name, :patronymic]
      t.index [:surname, :patronymic]
      t.timestamps
    end
    add_index :authors, :user_id, unique: true

    create_join_table :abstract_books, :authors do |t|
      t.index [:abstract_book_id, :author_id], unique: true
      # t.index [:abstract_book_id, :position], unique: true
      t.foreign_key :abstract_books, on_delete: :cascade
      t.foreign_key :authors, on_delete: :cascade
      t.integer :position, null: false
      t.timestamps
    end

    create_table :book_series do |t|
      t.string :name, limit: 50, null: false, index: true
      t.string :poster, limit: 255, null: true
      t.timestamps
    end
    create_join_table :abstract_books, :book_series do |t|
      # index name's limit (for pg) is 63 characters
      t.index [:abstract_book_id, :book_series_id], unique: true, name: 'unique_index_abstract_books__book_series'
      t.foreign_key :abstract_books, on_delete: :cascade
      t.foreign_key :book_series, on_delete: :cascade
    end
  end
end
