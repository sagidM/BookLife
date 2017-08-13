class Author < ApplicationRecord
  has_many :abstract_books_authors, class_name: 'AbstractBookAuthor'
  has_many :abstract_books, through: :abstract_books_authors
  has_one :user
  validates :first_name, length: {minimum: 2}
  validates :surname, length: {minimum: 2}

  mount_uploader :avatar, ImageUploader
end
