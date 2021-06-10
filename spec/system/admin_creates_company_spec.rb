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

    expect(current_path).to eq(course_path(Course.last))
    expect(page).to have_content('TeachTech')
    expect(page).to have_content('92107397000133')
    expect(page).to have_content('Rua A 123')
    expect(page).to have_content('contato@teachtech.com')
    expect(page).to have_link('Voltar')
  end

  it 'and attributes cannot be blank' do
    user_login
    visit root_path
    click_on 'Cursos'
    click_on 'Registrar um Curso'
    click_on 'Criar curso'

    expect(page).to have_content('não pode ficar em branco', count: 3)
    expect(page).to have_content('Instrutor(a) é obrigatório(a)')
  end

  it 'and code must be unique' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: instructor)
    user_login
    visit root_path
    click_on 'Cursos'
    click_on 'Registrar um Curso'
    fill_in 'Código', with: 'RUBYBASIC'
    click_on 'Criar curso'

    expect(page).to have_content('já está em uso')
  end
end