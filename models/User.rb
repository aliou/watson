require "securerandom"

class User < ActiveRecord::Base
  validate :mail, presence: true, uniqueness: true
  validate :password_digest, presence: true

  after_initialize do |user|
    user.api_key = SecureRandom.hex(15)
  end
end
