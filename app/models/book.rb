class Book < ApplicationRecord
  belongs_to :abstract_book
  has_many :authors, through: :abstract_book
  belongs_to :publishing_house

  validates :name, length: {minimum: 2, maximum: 50}
  validates :language, length: {minimum: 2, maximum: 5}
  validates :poster, presence: true
  validates :published_at, presence: true
  validate :check_type

  mount_uploader :poster, ImageUploader
  mount_uploader :background_image, ImageUploader


  def background_stable_image
    background_image.nil? ? poster : background_image
  end

  private
    def check_type
      unless type == Ebook::name or type == Audiobook::name
        errors[:type] << 'Type must be "Ebook" or "Audiobook"'
      end
    end
end