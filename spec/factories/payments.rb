FactoryBot.define do
  factory :payment do
    name { 'Dev Card' }
    type_payment { 'credito' }
    fee_percentage { '1.2' }
    max_fee { rand(50..100) }
    active { true }
    bank_code { '000' }
  end
end
