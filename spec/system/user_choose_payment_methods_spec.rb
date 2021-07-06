require 'rails_helper'

describe 'Admin Choose payment methods' do
  it 'pix' do
    payment_pix = Payment.create!(name: 'Banco Ximira', type_payment: 'pix',
                                  fee_percentage: '1.1', max_fee: '30', active: true, bank_code: '987')
    payment_credit = Payment.create!(name: 'Dev Card', type_payment: 'credito',
                                     fee_percentage: '1.2', max_fee: '50', active: true, bank_code: '000')
    company = Company.create!(name: 'TeachTech', cnpj: '92107397000133',
                              address: 'Rua A 123', email: 'contato@teachtech.com')
    user = User.create!(email: 'matheus@teachtech.com.br', password: '123456')
    login_as user, scope: :user
    visit company_path(company)
    click_on 'Adicionar Método de Pagamento'
    select "#{payment_pix.name} - #{payment_pix.type_payment}",
           from: 'Tipo de Pagamento'
    fill_in 'Chave', with: 'qweasdzxc123poi098lk'
    click_on 'Salvar'

    expect(page).to have_content('Banco Ximira - pix')
    expect(page).to have_content('qweasdzxc123poi098lk')
  end
  it 'credit card' do
    payment_pix = Payment.create!(name: 'Banco Ximira', type_payment: 'pix',
                                  fee_percentage: '1.1', max_fee: '30', active: true, bank_code: '987')
    payment_credit = Payment.create!(name: 'Dev Card', type_payment: 'credito',
                                     fee_percentage: '1.2', max_fee: '50', active: true, bank_code: '000')
    company = Company.create!(name: 'TeachTech', cnpj: '92107397000133',
                              address: 'Rua A 123', email: 'contato@teachtech.com')
    user = User.create!(email: 'matheus@teachtech.com.br', password: '123456')
    login_as user, scope: :user
    visit company_path(company)
    click_on 'Adicionar Método de Pagamento'
    select "#{payment_credit.name} - #{payment_credit.type_payment}",
           from: 'Tipo de Pagamento'
    fill_in 'Chave', with: 'qweasdzxc123poi098lk'
    click_on 'Salvar'

    expect(page).to have_content('Dev Card - credito')
    expect(page).to have_content('qweasdzxc123poi098lk')
  end
  it 'boleto' do
    payment_boleto = Payment.create!(name: 'Banco Ximira',
                                     type_payment: 'boleto', fee_percentage: '1.1', max_fee: '30', active: true, bank_code: '987')
    payment_credit = Payment.create!(name: 'Dev Card', type_payment: 'credito',
                                     fee_percentage: '1.2', max_fee: '50', active: true, bank_code: '000')
    company = Company.create!(name: 'TeachTech', cnpj: '92107397000133',
                              address: 'Rua A 123', email: 'contato@teachtech.com')
    user = User.create!(email: 'matheus@teachtech.com.br', password: '123456')
    login_as user, scope: :user
    visit company_path(company)
    click_on 'Adicionar Método de Pagamento'
    select "#{payment_boleto.name} - #{payment_boleto.type_payment}",
           from: 'Tipo de Pagamento'
    fill_in 'Agência', with: '1239'
    fill_in 'Número da conta', with: '12673-4'
    click_on 'Salvar'

    expect(page).to have_content('Banco Ximira - boleto')
    expect(page).to have_content('1239')
    expect(page).to have_content('12673-4')
  end
end
