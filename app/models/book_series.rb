class BookSeries < ApplicationRecord
  has_and_belongs_to_many :abstract_books
end
