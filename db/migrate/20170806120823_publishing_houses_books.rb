class PublishingHousesBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :publishing_houses do |t|
      t.string :name, limit: 50, null: false, index: true
      t.text :description, null: false
      t.string :logo, limit: 255
      t.date :year_of_foundation
      t.timestamps
    end

    create_table :books do |t|
      t.string :type, limit: 20, null: false, index: true
      t.references :abstract_book, foreign_key: {on_delete: :cascade}, null: false
      t.string :name, limit: 50, null: false, index: true
      t.string :poster, limit: 255, null: false
      t.string :background_image, limit: 255, null: true
      t.string :language, limit: 5, null: false
      t.date :published_at, null: false
      t.text :description
      t.references :publishing_house, foreign_key: true, null: false
      t.timestamps
    end
  end
end
