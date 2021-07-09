require 'rails_helper'

describe 'user applies discount to payment method' do
  it 'successfully' do
    company = create(:company)
    payment_credit = Payment.create!(name: 'Dev Card', type_payment: 'credito',
                                     fee_percentage: '1.2', max_fee: '50', active: true, bank_code: '000')
    payment_method = PaymentMethod.create!(payment_id: payment_credit.id,
                                           company_id: company.id, code: 'qweasdzxc123poi098lk')
    user = User.create!(email: 'matheus@teachtech.com.br', password: '123456')
    login_as user, scope: :user
    visit company_payment_method_path(payment_method.id, company.id)
    click_on 'Aplicar desconto para Forma de Pagamento'
    select "#{payment_credit.name} - #{payment_credit.type_payment}",
           from: 'Tipo de Pagamento'
    fill_in 'Desconto (%)', with: '5'
    click_on 'Salvar'

    expect(current_path).to eq(company_payment_method_discount_path(company.id,
                                                                    payment_method.id, Discount.last))
    expect(page).to have_content('TeachTech')
    expect(page).to have_content('Dev Card - credito')
    expect(page).to have_content('5%')
  end
  it 'discount percentage can not be blank' do
    company = create(:company)
    payment_credit = Payment.create!(name: 'Dev Card', type_payment: 'credito',
                                     fee_percentage: '1.2', max_fee: '50', active: true, bank_code: '000')
    payment_method = PaymentMethod.create!(payment_id: payment_credit.id,
                                           company_id: company.id, code: 'qweasdzxc123poi098lk')
    user = User.create!(email: 'matheus@teachtech.com.br', password: '123456')
    login_as user, scope: :user
    visit company_payment_method_path(payment_method.id, company.id)
    click_on 'Aplicar desconto para Forma de Pagamento'
    click_on 'Salvar'

    expect(page).to have_content('não pode ficar em branco')
  end
end
