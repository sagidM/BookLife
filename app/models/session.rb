class Session < ApplicationRecord
  belongs_to :user
  validates :remember_token, presence: true
  validates :ip_address, presence: true
end
