FactoryBot.define do
  factory :payment_method do
    payment
    company
    sequence(:code) { |n| "qweasdzxc123poi098l#{n}" }
  end
end
