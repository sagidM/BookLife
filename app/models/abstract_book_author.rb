class AbstractBookAuthor < ApplicationRecord
  self.table_name = 'abstract_books_authors'
  belongs_to :author
  belongs_to :abstract_book
end