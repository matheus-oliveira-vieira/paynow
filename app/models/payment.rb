class Payment < ApplicationRecord
  enum type: { 'pix': 5 , 'boleto': 10, 'cartão de crédito': 15 }
  has_one_attached :logo
end
