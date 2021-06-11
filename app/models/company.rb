class Company < ApplicationRecord
  validates :name, :cnpj, :email, :address, presence: true
end
