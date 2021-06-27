class Discount < ApplicationRecord
  audited
  validates :discount_percentage, presence: true
  belongs_to :company
  belongs_to :payment_method
end
