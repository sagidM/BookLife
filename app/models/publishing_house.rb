class PublishingHouse < ApplicationRecord
  has_many :ebooks
  has_many :audiobooks
  validates :name, length: {minimum: 2}
  validates :description, length: {minimum: 6}

  mount_uploader :logo, ImageUploader
end
