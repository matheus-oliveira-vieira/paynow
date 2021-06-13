require 'rails_helper'

describe 'admin updates payment' do
  it 'successfully' do
    payment = Payment.create!(name: 'Banco Ximira', type_payment: 5, fee_percentage: 1.1, max_fee: 30, active: true)

    visit payment_path(payment)
    click_on 'Editar'
    fill_in 'Nome do Pagamento', with: 'Banco Peixola'
      select 'boleto', from: 'Tipo de Pagamento'
      fill_in 'Taxa por Cobrança', with: '1.5'
      fill_in 'Taxa máxima (R$)', with: '50'
    click_on 'Salvar'

    expect(page).to have_content('Banco Peixola')
    expect(page).to have_content('boleto')
    expect(page).to have_content('1,5%')
    expect(page).to have_content('R$ 50,00')
  end

  it 'and active payment' do
    payment = Payment.create!(name: 'Banco Ximira', type_payment: 5, fee_percentage: 1.1, max_fee: 30, active: false)
    
    visit payment_path(payment)
    click_on 'Ativar'

    expect(page).to have_content('Ativo')
  end

  it 'and inactive payment' do
    payment = Payment.create!(name: 'Banco Ximira', type_payment: 5, fee_percentage: 1.1, max_fee: 30, active: true)
    
    visit payment_path(payment)
    click_on 'Inativar'

    expect(page).to have_content('Inativo')
  end
end