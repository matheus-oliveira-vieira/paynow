require 'securerandom'
class Client < ApplicationRecord
  def self.generate_token
    token = SecureRandom.hex(20)
  end
end
