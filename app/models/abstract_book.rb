class AbstractBook < ApplicationRecord
  has_many :abstract_books_authors, class_name: 'AbstractBookAuthor'
  has_many :authors, through: :abstract_books_authors
  has_and_belongs_to_many :book_series
end
