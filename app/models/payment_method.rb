class PaymentMethod < ApplicationRecord
  belongs_to :payment
  belongs_to :company
  before_create :adjust_blank_fields

  def display_name
    "#{self.payment.name} - #{self.payment.type_payment}"
  end

  private
  def adjust_blank_fields
    if Payment.find(self.payment_id).type_payment == 'pix' || Payment.find(self.payment_id).type_payment == 'credito'
      self.agency = '000'
      self.bank_account = '000'
    end
  end

end
