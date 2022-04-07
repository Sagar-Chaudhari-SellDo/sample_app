class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  attr_accessor :remember_token
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A([a-z0-9_\-\.]+)@([a-z0-9\-]+\.)([a-z]{2,4}|[0-9]{1,3})\z/i
  validates :email, presence: true, length: {maximum: 255}, 
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: {minimum: 6}

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
          BCrypt::Engine.cost
          BCrypt::Password.create(string, cost: cost)
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end