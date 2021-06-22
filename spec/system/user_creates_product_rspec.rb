require 'rails_helper'

describe 'user creates product' do
  it 'successfully' do
    company = Company.create!(name: 'TeachTech', cnpj: '92107397000133', address: 'Rua A 123', email: 'contato@teachtech.com')

    visit company_path(company)
    click_on 'Adicionar produto'
    fill_in 'Nome do Produto', with: 'Curso de Ruby on Rails'
    fill_in 'Valor (R$)', with: '30'
    click_on 'Salvar'

    
    expect(page).to have_content('Curso de Ruby on Rails')
    expect(page).to have_content('R$ 30,00')
  end
end