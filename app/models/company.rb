require 'securerandom'
class Company < ApplicationRecord
  validates :name, :cnpj, :email, :address, presence: true
  before_create :generate_token

  def refresh_token!
    self.generate_token
    self.save
   end
   
  private
    def generate_token
      self.token = SecureRandom.hex(20)
    end
end
