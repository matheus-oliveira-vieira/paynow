require 'rails_helper'

describe 'User view charges' do
  it 'from 30 days ago' do
    company = create(:company)
    product = Product.create!(name: 'Curso de Ruby on Rails', price: 30, company_id: company.id)
    payment_credit = create(:payment)
    payment_boleto = Payment.create!(name: 'Banco Ximira', type_payment: 'boleto', fee_percentage: '1.1', max_fee: '30', active: true, bank_code: '987')
    payment_method1 = create(:payment_method)
    payment_method2 = PaymentMethod.create!(payment_id: payment_boleto.id, company_id: company.id, agency: '123', bank_account: '1234-5')
    client1 = Client.create!(name: 'Matheus Oliveira', cpf: '12312312512')
    client2 = Client.create!(name: 'Gabriela Oliveira', cpf: '12312312512')
    client3 = Client.create!(name: 'Jucelino Oliveira', cpf: '12312312512')
    discount1 = Discount.create!(company_id: company.id, payment_method_id: payment_method1.id, discount_percentage:5)
    discount2 = Discount.create!(company_id: company.id, payment_method_id: payment_method2.id, discount_percentage:5)
    charge1 = Charge.create!(company_id: company.id, product_id: product.id, payment_method_id: payment_method1.id,
                            client_id: client1.id, discount_id: discount1.id, card_name: 'MATHEUS O VIEIRA',
                            card_number: '1234567890123456', card_code: '789', original_price: product.price,
                            new_price: 28.5, expiration_date:'30/06/2021', status: 'pendente')
    charge2 = Charge.create!(company_id: company.id, product_id: product.id, payment_method_id: payment_method2.id,
                            client_id: client2.id, discount_id: discount2.id, boleto_address: 'Rua B 234', original_price: product.price,
                            new_price: 28.5, expiration_date: 30.days.ago.to_date, status: 'aprovada')
    charge3 = Charge.create!(company_id: company.id, product_id: product.id, payment_method_id: payment_method2.id,
                            client_id: client3.id, discount_id: discount2.id, boleto_address: 'Rua C 345', original_price: product.price,
                            new_price: 28.5, expiration_date: 90.days.ago.to_date, status: 'pendente')
    
    visit charges_path
    save_page
    choose "q_#{30.days.ago.to_date}"
    click_on 'Pesquisar'
    expect(page).to have_text('Curso de Ruby on Rails')
    expect(page).to have_text(30.days.ago.to_date.to_s)
    expect(page).to have_text('Gabriela Oliveira')
    expect(page).to have_text('aprovada')
  end

  it 'from 90 days ago' do
    company = Company.create!(name: 'TeachTech', cnpj: '92107397000133', address: 'Rua A 123', email: 'contato@teachtech.com')
    product = Product.create!(name: 'Curso de Ruby on Rails', price: 30, company_id: company.id)
    payment_credit = Payment.create!(name: 'Dev Card', type_payment: 'credito', fee_percentage: '1.2', max_fee: '50', active: true, bank_code: '000')
    payment_boleto = Payment.create!(name: 'Banco Ximira', type_payment: 'boleto', fee_percentage: '1.1', max_fee: '30', active: true, bank_code: '987')
    payment_method1 = PaymentMethod.create!(payment_id: payment_credit.id, company_id: company.id, code: 'qweasdzxc123poi098lk')
    payment_method2 = PaymentMethod.create!(payment_id: payment_boleto.id, company_id: company.id, agency: '123', bank_account: '1234-5')
    client1 = Client.create!(name: 'Matheus Oliveira', cpf: '12312312512')
    client2 = Client.create!(name: 'Gabriela Oliveira', cpf: '12312312512')
    client3 = Client.create!(name: 'Jucelino Oliveira', cpf: '12312312512')
    discount1 = Discount.create!(company_id: company.id, payment_method_id: payment_method1.id, discount_percentage:5)
    discount2 = Discount.create!(company_id: company.id, payment_method_id: payment_method2.id, discount_percentage:5)
    charge1 = Charge.create!(company_id: company.id, product_id: product.id, payment_method_id: payment_method1.id,
                            client_id: client1.id, discount_id: discount1.id, card_name: 'MATHEUS O VIEIRA',
                            card_number: '1234567890123456', card_code: '789', original_price: product.price,
                            new_price: 28.5, expiration_date:'30/06/2021', status: 'pendente')
    charge2 = Charge.create!(company_id: company.id, product_id: product.id, payment_method_id: payment_method2.id,
                            client_id: client2.id, discount_id: discount2.id, boleto_address: 'Rua B 234', original_price: product.price,
                            new_price: 28.5, expiration_date: 30.days.ago.to_date, status: 'aprovada')
    charge3 = Charge.create!(company_id: company.id, product_id: product.id, payment_method_id: payment_method2.id,
                            client_id: client3.id, discount_id: discount2.id, boleto_address: 'Rua C 345', original_price: product.price,
                            new_price: 28.5, expiration_date: 90.days.ago.to_date, status: 'pendente')
    
    visit charges_path
    save_page
    choose "q_#{90.days.ago.to_date}"
    click_on 'Pesquisar'
    expect(page).to have_text('Curso de Ruby on Rails')
    expect(page).to have_text(90.days.ago.to_date.to_s)
    expect(page).to have_text('Jucelino Oliveira')
    expect(page).to have_text('pendente')
  end

  it 'all registers' do
    company = Company.create!(name: 'TeachTech', cnpj: '92107397000133', address: 'Rua A 123', email: 'contato@teachtech.com')
    product = Product.create!(name: 'Curso de Ruby on Rails', price: 30, company_id: company.id)
    payment_credit = Payment.create!(name: 'Dev Card', type_payment: 'credito', fee_percentage: '1.2', max_fee: '50', active: true, bank_code: '000')
    payment_boleto = Payment.create!(name: 'Banco Ximira', type_payment: 'boleto', fee_percentage: '1.1', max_fee: '30', active: true, bank_code: '987')
    payment_method1 = PaymentMethod.create!(payment_id: payment_credit.id, company_id: company.id, code: 'qweasdzxc123poi098lk')
    payment_method2 = PaymentMethod.create!(payment_id: payment_boleto.id, company_id: company.id, agency: '123', bank_account: '1234-5')
    client1 = Client.create!(name: 'Matheus Oliveira', cpf: '12312312512')
    client2 = Client.create!(name: 'Gabriela Oliveira', cpf: '12312312512')
    client3 = Client.create!(name: 'Jucelino Oliveira', cpf: '12312312512')
    discount1 = Discount.create!(company_id: company.id, payment_method_id: payment_method1.id, discount_percentage:5)
    discount2 = Discount.create!(company_id: company.id, payment_method_id: payment_method2.id, discount_percentage:5)
    charge1 = Charge.create!(company_id: company.id, product_id: product.id, payment_method_id: payment_method1.id,
                            client_id: client1.id, discount_id: discount1.id, card_name: 'MATHEUS O VIEIRA',
                            card_number: '1234567890123456', card_code: '789', original_price: product.price,
                            new_price: 28.5, expiration_date:'30/06/2021', status: 'pendente')
    charge2 = Charge.create!(company_id: company.id, product_id: product.id, payment_method_id: payment_method2.id,
                            client_id: client2.id, discount_id: discount2.id, boleto_address: 'Rua B 234', original_price: product.price,
                            new_price: 28.5, expiration_date: 30.days.ago.to_date, status: 'aprovada')
    charge3 = Charge.create!(company_id: company.id, product_id: product.id, payment_method_id: payment_method2.id,
                            client_id: client3.id, discount_id: discount2.id, boleto_address: 'Rua C 345', original_price: product.price,
                            new_price: 28.5, expiration_date: 90.days.ago.to_date, status: 'pendente')
    
    visit charges_path
    save_page
    choose "q_1"
    click_on 'Pesquisar'
    
    expect(page).to have_text('Gabriela Oliveira')
    expect(page).to have_text('Matheus Oliveira')
    expect(page).to have_text('Jucelino Oliveira')
    
  end
end