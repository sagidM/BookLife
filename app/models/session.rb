class Session < ApplicationRecord
  belongs_to :user
  validates :remember_token, presence: true
  validate { if ip_address.nil?; ip_address = request.ip_address; end }
end
