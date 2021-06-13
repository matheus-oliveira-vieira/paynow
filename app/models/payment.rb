class Payment < ApplicationRecord
  validates :name, :type_payment, :fee_percentage, :max_fee, presence: true
  enum type_payment: { pix: 5 , boleto: 10, credito: 15 }
  has_one_attached :logo
end
