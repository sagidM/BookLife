class User < ApplicationRecord
  has_one :author
  has_many :sessions
  has_secure_password
  validates :email, format: {with: /\A[-.\w0-9]+@[-.\w0-9]+\.[-.\w0-9]+\Z/},
            presence: true, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 6}
  validates :first_name, presence: true
  validate :bdate_cannot_be_in_the_future

  before_save { self.email.downcase! }

  def self.encrypt(str)
    Digest::SHA1.hexdigest str
  end

  private
    def bdate_cannot_be_in_the_future
      unless bdate.nil?
        today = Date.today
        errors.add :bdate, 'bdate cannot be in the future' if bdate > today
        errors.add :bdate, 'bdate cannot be so close to today' if bdate > today-1.year
      end
    end
end
