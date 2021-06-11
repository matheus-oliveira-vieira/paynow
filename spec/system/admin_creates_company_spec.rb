require 'rails_helper'

describe 'Admin registers companies' do
  it 'successfully' do

    visit root_path
    click_on 'Empresas'
    click_on 'Registrar uma Empresa'

    fill_in 'Razão Social', with: 'TeachTech'
    fill_in 'CNPJ', with: '92107397000133'
    fill_in 'Endereço de Faturamento', with: 'Rua A 123'
    fill_in 'E-mail para Faturamento', with: 'contato@teachtech.com'
    click_on 'Criar Empresa'

    expect(current_path).to eq(company_path(Company.last))
    expect(page).to have_content('TeachTech')
    expect(page).to have_content('92107397000133')
    expect(page).to have_content('Rua A 123')
    expect(page).to have_content('contato@teachtech.com')
    expect(page).to have_link('Voltar')
  end

  it 'and attributes cannot be blank' do
    
    visit root_path
    click_on 'Empresas'
    click_on 'Registrar uma Empresa'
    click_on 'Criar Empresa'

    expect(page).to have_content('não pode ficar em branco')
  end
end