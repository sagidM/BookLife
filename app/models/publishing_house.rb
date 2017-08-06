class PublishingHouse < ApplicationRecord
  has_many :ebooks
  has_many :audiobooks
end
