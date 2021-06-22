class Discount < ApplicationRecord
  audited
  belongs_to :product
  belongs_to :payment_method
end
