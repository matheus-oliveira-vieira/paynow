require 'rails_helper'

describe 'user applies discount to product' do
  it 'successfully' do
    company = Company.create!(name: 'TeachTech', cnpj: '92107397000133', address: 'Rua A 123', email: 'contato@teachtech.com')
    payment_credit = Payment.create!(name: 'Dev Card', type_payment: 'credito', fee_percentage: '1.2', max_fee: '50', active: true, bank_code: '000')
    payment_method = PaymentMethod.create!(payment_id: payment_credit.id, company_id: company.id, code: 'qweasdzxc123poi098lk')
    product = Product.create!(name: 'Curso de Ruby on Rails', price: 30, company_id: company.id)

    visit company_payment_method_path(payment_method.id, company.id)
    click_on 'Aplicar desconto para Forma de Pagamento'
    select "#{payment_credit.name} - #{payment_credit.type_payment}", from: 'Tipo de Pagamento'
    fill_in 'Desconto (%)', with: '5'
    click_on 'Salvar'
    save_page
  end
end