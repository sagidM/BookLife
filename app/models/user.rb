class User < ApplicationRecord
  has_many :sessions
  has_secure_password
  validates :email, format: {with: /\A[\w-]+\@[\w-]+\.[\w-]+\Z/},
            presence: true, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 6}
  validates :first_name, presence: true
  validate :bdate_cannot_be_in_the_future

  before_save { self.email.downcase! }

  private
    def bdate_cannot_be_in_the_future
      unless bdate.nil?
        today = Date.today
        errors.add :bdate, 'bdate cannot be in the future' if bdate > today
        errors.add :bdate, 'bdate cannot be so close to today' if bdate > today-1.year
      end
    end
end
