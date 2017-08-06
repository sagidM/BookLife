class Book < ApplicationRecord
  belongs_to :abstract_book
  has_many :authors, through: :abstract_book
  belongs_to :publishing_house

  def background_stable_image
    background_image.nil? ? poster : background_image
  end
end