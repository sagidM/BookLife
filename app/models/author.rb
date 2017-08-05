class Author < ApplicationRecord
  has_many :abstract_books_authors, class_name: 'AbstractBookAuthor'
  has_many :abstract_books, through: :abstract_books_authors
  has_one :user
end
