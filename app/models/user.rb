class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true,  length: { maximum: 20 }
  validates :password, presence: true, length: { minimum: 8 }
  has_secure_password
end