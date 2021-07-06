require 'securerandom'
class PaymentMethod < ApplicationRecord
  belongs_to :payment
  belongs_to :company
  before_create :adjust_blank_fields

  def display_name
    "#{payment.name} - #{payment.type_payment}"
  end

  def send_payment_confirmation
    SecureRandom.hex(10)
  end

  private

  def adjust_blank_fields
    if Payment.find(payment_id).type_payment == 'pix' || Payment.find(payment_id).type_payment == 'credito'
      self.agency = '000'
      self.bank_account = '000'
    end
  end
end
