require 'rails_helper'

describe 'Admin registers payments' do
  it 'successfully' do

    visit root_path
    click_on 'Formas de Pagamento'
    click_on 'Registrar uma Forma de Pagamento'

    fill_in 'Nome do Pagamento', with: 'Banco Ximira'
    select 'pix', from: 'Tipo de Pagamento'
    fill_in 'Código Bancário', with: '987'
    fill_in 'Taxa por Cobrança', with: '1.1'
    fill_in 'Taxa máxima (R$)', with: '30'
    attach_file 'Logo', Rails.root.join('spec/fixtures/logo.png')
    click_on 'Criar Forma de Pagamento'
    
    expect(current_path).to eq(payment_path(Payment.last))
    expect(page).to have_content('Banco Ximira')
    expect(page).to have_content('pix')
    expect(page).to have_content('1,1%')
    expect(page).to have_content('R$ 30,00')
    expect(page).to have_css('img[src*="logo.png"]')
    expect(page).to have_link('Voltar')
  end

  it 'credit card' do

    visit root_path
    click_on 'Formas de Pagamento'
    click_on 'Registrar uma Forma de Pagamento'

    fill_in 'Nome do Pagamento', with: 'Dev Card'
    select 'credito', from: 'Tipo de Pagamento'
    fill_in 'Taxa por Cobrança', with: '1.1'
    fill_in 'Taxa máxima (R$)', with: '30'
    attach_file 'Logo', Rails.root.join('spec/fixtures/logo.png')
    click_on 'Criar Forma de Pagamento'
    
    expect(current_path).to eq(payment_path(Payment.last))
    expect(page).to have_content('Dev Card')
    expect(page).to have_content('credito')
    expect(page).to have_content('1,1%')
    expect(page).to have_content('R$ 30,00')
    expect(page).to have_css('img[src*="logo.png"]')
    expect(page).to have_link('Voltar')
  end

  it 'and attributes cannot be blank' do
    visit root_path
    click_on 'Formas de Pagamento'
    click_on 'Registrar uma Forma de Pagamento'
    click_on 'Criar Forma de Pagamento'
    
    expect(page).to have_content('não pode ficar em branco')
  end
end