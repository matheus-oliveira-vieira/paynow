require 'securerandom'
class Company < ApplicationRecord
  audited
  validates :name, :cnpj, :email, :address, presence: true
  before_create :generate_token

  def refresh_token!
    generate_token
    save
  end

  private

  def generate_token
    self.token = SecureRandom.hex(20)
  end
end
