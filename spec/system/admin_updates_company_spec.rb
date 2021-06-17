require 'rails_helper'

describe 'admin updates company' do
  it 'successfully' do
    company = Company.create!(name: 'TeachTech', cnpj: '92107397000133', address: 'Rua A 123', email: 'contato@teachtech.com')

    visit company_path(company)
    click_on 'Editar'
    fill_in 'Razão Social', with: 'EnsinaDev'
    fill_in 'CNPJ', with: '03218408000144'
    fill_in 'Endereço de Faturamento', with: 'Rua B 456'
    fill_in 'E-mail para Faturamento', with: 'contato@ensinadev.com'
    click_on 'Salvar'

    expect(page).to have_content('EnsinaDev')
    expect(page).to have_content('03218408000144')
    expect(page).to have_content('Rua B 456')
    expect(page).to have_content('contato@ensinadev.com')
  end

  it 'request new token' do
    company = Company.create!(name: 'TeachTech', cnpj: '92107397000133', address: 'Rua A 123', email: 'contato@teachtech.com')
    
    visit company_path(company)
    click_on 'Atualizar Token'
    
    expect(page).to have_text('Token atualizado com sucesso')
    expect(current_path).to eq(company_path(company))

  end
end