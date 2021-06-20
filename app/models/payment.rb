class Payment < ApplicationRecord
  validates :name, :type_payment, :fee_percentage, :max_fee, presence: true
  validates :bank_code, length: { maximum: 3 }
  enum type_payment: { pix: 5 , boleto: 10, credito: 15 }
  has_one_attached :logo
  before_create :set_bank_to_credit

  def display_name
    "#{name} - #{type_payment}"
  end

  private
  def set_bank_to_credit
    if self.type_payment == 'credito'
      self.bank_code = '000'
    end
  end
end
