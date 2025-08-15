class User < ApplicationRecord
  validates :name, length: { minimum: 0, maximum: 25 }, allow_blank: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.exists?(email)
    User.where(email: email).length > 0
  end
end
