class User < ApplicationRecord
  before_save do 
    self.email = email.downcase
    self.username = username.downcase
  end

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_USERNAME_REGEX = /\A[a-z0-9_]+\z/i

  validates :username, presence: true, length: { maximum: 50 }, format: { with: VALID_USERNAME_REGEX }, 
            uniqueness: { case_sensitive: false }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, 
            uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_blank: true

  # Class method for finding a user ONLY if we have the correct username and password
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user
    user.is_password?(password) ? user : nil
  end

  def is_password?(password)
    # Use BCrypt's built-in method for checking if the password provided is the user's password
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end