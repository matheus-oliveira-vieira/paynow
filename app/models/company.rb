require 'securerandom'
class Company < ApplicationRecord
  validates :name, :cnpj, :email, :address, presence: true
  before_create :generate_token

  private
    def generate_token
      self.token = SecureRandom.hex(20)
    end
end
