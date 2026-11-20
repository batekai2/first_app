class User < ApplicationRecord
  has_secure_password

  has_many :posts, dependent: :restrict_with_exception

  normalizes :email, with: ->(email) { email.strip.downcase }

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password,
            length: { minimum: 12, maximum: 72 },
            if: -> { new_record? || password.present? }
end
