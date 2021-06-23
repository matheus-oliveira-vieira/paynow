class Discount < ApplicationRecord
  audited
  belongs_to :company
  belongs_to :payment_method
end
