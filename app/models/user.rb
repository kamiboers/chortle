class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true,  length: { in: 4..20 }
  validates :password, presence: true, length: { in: 8..20 }
  has_secure_password
end