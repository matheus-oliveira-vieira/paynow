require 'rails_helper'

describe 'Account Management' do
  context 'registration' do
    it 'paynow with email and password' do
      visit root_path
      click_on 'Registrar-me'
      fill_in 'Email', with: 'matheus@paynow.com.br'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de Senha', with: '123456'
      click_on 'Criar conta'

      expect(current_path).to eq(root_path)
      expect(page).to have_text('Login efetuado com sucesso')
      expect(page).to have_link('Sair')
    end

    it 'company owner with email and password' do
      visit root_path
      click_on 'Registrar-me'
      fill_in 'Email', with: 'matheus@teachtech.com.br'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de Senha', with: '123456'
      click_on 'Criar conta'

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

    it 'employee with email and password' do
      company = Company.create!(name: 'TeachTech', cnpj: '92107397000133',
                                address: 'Rua A 123', email: 'contato@teachtech.com')

      visit root_path
      click_on 'Registrar-me'
      fill_in 'Email', with: 'ruth@teachtech.com.br'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de Senha', with: '123456'
      click_on 'Criar conta'

      expect(current_path).to eq(root_path)
      expect(page).to have_text('Login efetuado com sucesso')
      expect(page).to have_link('Sair')
    end

    it 'with domain email not valid' do
      visit root_path
      click_on 'Registrar-me'
      fill_in 'Email', with: 'carla@gmail.com.br'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de Senha', with: '123456'
      click_on 'Criar conta'

      expect(page).to have_text('Domínio inválido')
    end
  end
  context 'logout' do
    it 'successfully' do
      user = User.create!(email: 'matheus@paynow.com.br', password: '123456')

      login_as user, scope: :user
      visit root_path
      click_on 'Sair'

      expect(page).to have_text('Saiu com sucesso')
      expect(page).to_not have_text('matheus@paynow.com.br')
      expect(current_path).to eq(root_path)
      # expect(page).to have_link('Registrar-me')
      expect(page).to have_link('Entrar')
      expect(page).to_not have_link('Sair')
    end
  end
end
