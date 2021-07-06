require 'securerandom'
class Charge < ApplicationRecord
  belongs_to :company
  belongs_to :product
  belongs_to :payment_method
  belongs_to :client
  belongs_to :discount
  enum status: { pendente: 5, aprovada: 10, rejeitada: 15 }
  before_create :generate_token

  private

  def generate_token
    self.token = SecureRandom.hex(20)
  end
end
