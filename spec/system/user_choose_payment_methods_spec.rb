require 'rails_helper'

describe 'Admin Choose payment methods' do
  it 'pix' do
    company = Company.create!(name: 'TeachTech', cnpj: '92107397000133', address: 'Rua A 123', email: 'contato@teachtech.com')
    payment_pix = Payment.create!(name: 'Banco Ximira', type_payment: 'pix', fee_percentage: '1.1', max_fee: '30', active: true, bank_code: '987')
    payment_credit = Payment.create!(name: 'Dev Card', type_payment: 'credito', fee_percentage: '1.2', max_fee: '50', active: true, bank_code: '000')
    
    visit company_path(company)
    click_on 'Adicionar Método de Pagamento'
    select "#{payment_pix.name} - #{payment_pix.type_payment}", from: 'Tipo de Pagamento'
    fill_in 'Chave PIX', with: 'qweasdzxc123poi098lk'
    click_on 'Salvar'

    expect(page).to have_content('Banco Ximira - pix')
    expect(page).to have_content('qweasdzxc123poi098lk')

  end
end