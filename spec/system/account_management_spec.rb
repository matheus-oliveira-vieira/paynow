require 'rails_helper'

describe 'Account Management' do
  context 'registration' do
    it 'with email and password' do
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

    xit 'without valid field' do
    end

    xit 'password not match confirmation' do
    end

    xit 'with email not unique' do
    end
  end
end