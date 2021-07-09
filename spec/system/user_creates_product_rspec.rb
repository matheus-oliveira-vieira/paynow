require 'rails_helper'

describe 'user creates product' do
  it 'successfully' do
    company = create(:company)
    user = User.create!(email: 'matheus@teachtech.com.br', password: '123456')
    login_as user, scope: :user
    visit company_path(company)
    click_on 'Adicionar produto'
    fill_in 'Nome do Produto', with: 'Curso de Ruby on Rails'
    fill_in 'Valor (R$)', with: '30'
    click_on 'Salvar'

    expect(page).to have_content('Curso de Ruby on Rails')
    expect(page).to have_content('R$ 30,00')
  end

  it 'and attributes cannot be blank' do
    company = create(:company)
    user = User.create!(email: 'matheus@teachtech.com.br', password: '123456')
    login_as user, scope: :user
    visit company_path(company)
    click_on 'Adicionar produto'
    click_on 'Salvar'

    expect(page).to have_content('não pode ficar em branco')
  end
end
