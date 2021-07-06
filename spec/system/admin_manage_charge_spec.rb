require 'rails_helper'

describe 'Admin manage charges' do
  it 'and accept successfully' do
    company = Company.create!(name: 'TeachTech', cnpj: '92107397000133',
                              address: 'Rua A 123', email: 'contato@teachtech.com')
    product = Product.create!(name: 'Curso de Ruby on Rails', price: 30,
                              company_id: company.id)
    payment_credit = Payment.create!(name: 'Dev Card', type_payment: 'credito',
                                     fee_percentage: '1.2', max_fee: '50', active: true, bank_code: '000')
    payment_method = PaymentMethod.create!(payment_id: payment_credit.id,
                                           company_id: company.id, code: 'qweasdzxc123poi098lk')
    client = Client.create!(name: 'Matheus Oliveira', cpf: '12312312512')
    discount = Discount.create!(company_id: company.id,
                                payment_method_id: payment_method.id, discount_percentage: 5)
    charge = Charge.create!(company_id: company.id, product_id: product.id, payment_method_id: payment_method.id,
                            client_id: client.id, discount_id: discount.id, card_name: 'MATHEUS O VIEIRA',
                            card_number: '1234567890123456', card_code: '789', original_price: product.price,
                            new_price: 28.5, expiration_date: '30/06/2021', status: 'pendente')

    visit root_path
    click_on 'Ver todas as cobranças'
    click_on 'Alterar Status da Cobrança'
    choose :charge_status_aprovada
    fill_in 'Data efetiva da operação', with: '25/06/2021'
    click_on 'Salvar'

    expect(page).to have_content('Curso de Ruby on Rails')
    expect(page).to have_content('30/06/2021')
    expect(page).to have_content('25/06/2021')
  end
  it 'and reject successfully' do
    company = Company.create!(name: 'TeachTech', cnpj: '92107397000133',
                              address: 'Rua A 123', email: 'contato@teachtech.com')
    product = Product.create!(name: 'Curso de Ruby on Rails', price: 30,
                              company_id: company.id)
    payment_credit = Payment.create!(name: 'Dev Card', type_payment: 'credito',
                                     fee_percentage: '1.2', max_fee: '50', active: true, bank_code: '000')
    payment_method = PaymentMethod.create!(payment_id: payment_credit.id,
                                           company_id: company.id, code: 'qweasdzxc123poi098lk')
    client = Client.create!(name: 'Matheus Oliveira', cpf: '12312312512')
    discount = Discount.create!(company_id: company.id,
                                payment_method_id: payment_method.id, discount_percentage: 5)
    charge = Charge.create!(company_id: company.id, product_id: product.id, payment_method_id: payment_method.id,
                            client_id: client.id, discount_id: discount.id, card_name: 'MATHEUS O VIEIRA',
                            card_number: '1234567890123456', card_code: '789', original_price: product.price,
                            new_price: 28.5, expiration_date: '30/06/2021', status: 'pendente')

    visit root_path
    click_on 'Ver todas as cobranças'
    click_on 'Alterar Status da Cobrança'
    choose :charge_status_pendente
    fill_in 'Data efetiva da operação', with: '25/06/2021'
    fill_in 'Código de erro', with: '01'
    click_on 'Salvar'
    click_on 'Ver todas as cobranças'

    expect(page).to have_content('pendente')
  end
end
