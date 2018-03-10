class User < ApplicationRecord
  before_save { self.username = username.downcase }
  validates :username, presence: true, uniqueness: true,  length: { in: 4..20 }
  validates :password, presence: true, length: { in: 8..20 }
  has_secure_password

  attr_accessor :session_token

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def set_session_token
    self.session_token = User.new_token
    update_attribute(:session_digest, User.digest(session_token))
  end

  def authenticated?(session_token)
    BCrypt::Password.new(session_digest).is_password?(session_token)
  end
end