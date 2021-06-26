require 'rails_helper'

describe 'Charges API' do
  context 'POST /api/v1/charges' do
    it 'should create a charge with credit card' do
      company = Company.create!(name: 'TeachTech', cnpj: '92107397000133', address: 'Rua A 123', email: 'contato@teachtech.com')
      product = Product.create!(name: 'Curso de Ruby on Rails', price: 30, company_id: company.id)
      payment_credit = Payment.create!(name: 'Dev Card', type_payment: 'credito', fee_percentage: '1.2', max_fee: '50', active: true, bank_code: '000')
      payment_method = PaymentMethod.create!(payment_id: payment_credit.id, company_id: company.id, code: 'qweasdzxc123poi098lk')
      client = Client.create!(name: 'Matheus Oliveira', cpf: '12312312512')
      discount = Discount.create!(company_id: company.id, payment_method_id: payment_method.id, discount_percentage:5)

      post '/api/v1/charges', params: { 
        charge: { 
          company_id: company.id, product_id: product.id, payment_method_id: payment_method.id,
          client_id: client.id, discount_id: discount.id, card_name: 'MATHEUS O VIEIRA',
          card_number: '1234567890123456', card_code: '789', original_price: product.price,
          new_price: 28.5, status: 'pendente'
        },
      }

      expect(response).to have_http_status(201)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['card_name']).to eq('MATHEUS O VIEIRA')
      expect(parsed_body['original_price']).to eq('30.0')
      expect(parsed_body['new_price']).to eq('28.5')
    end

    it 'should create a charge with boleto' do
      company = Company.create!(name: 'TeachTech', cnpj: '92107397000133', address: 'Rua A 123', email: 'contato@teachtech.com')
      product = Product.create!(name: 'Curso de Ruby on Rails', price: 30, company_id: company.id)
      payment_boleto = Payment.create!(name: 'Banco Ximira', type_payment: 'boleto', fee_percentage: '1.1', max_fee: '30', active: true, bank_code: '987')
      payment_method = PaymentMethod.create!(payment_id: payment_boleto.id, company_id: company.id, agency: '1234', bank_account: '8524-9')
      client = Client.create!(name: 'Matheus Oliveira', cpf: '12312312512')
      discount = Discount.create!(company_id: company.id, payment_method_id: payment_method.id, discount_percentage:5)

      post '/api/v1/charges', params: { 
        charge: { 
          company_id: company.id, product_id: product.id, payment_method_id: payment_method.id,
          client_id: client.id, discount_id: discount.id, boleto_address: 'Rua A 123', original_price: product.price,
          new_price: 28.5, status: 'pendente'
        },
      }

      expect(response).to have_http_status(201)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['boleto_address']).to eq('Rua A 123')
      expect(parsed_body['original_price']).to eq('30.0')
      expect(parsed_body['new_price']).to eq('28.5')
    end
    
  end

  context 'GET /api/v1/charges/:charge_id/searches' do
    it'search by expiration date' do
      company = Company.create!(name: 'TeachTech', cnpj: '92107397000133', address: 'Rua A 123', email: 'contato@teachtech.com')
      product = Product.create!(name: 'Curso de Ruby on Rails', price: 30, company_id: company.id)
      payment_credit = Payment.create!(name: 'Dev Card', type_payment: 'credito', fee_percentage: '1.2', max_fee: '50', active: true, bank_code: '000')
      payment_method = PaymentMethod.create!(payment_id: payment_credit.id, company_id: company.id, code: 'qweasdzxc123poi098lk')
      client1 = Client.create!(name: 'Matheus Oliveira', cpf: '12312312512')
      client2 = Client.create!(name: 'Gabriela Oliveira', cpf: '12312312512')
      client3 = Client.create!(name: 'Jucelino Oliveira', cpf: '12312312512')
      discount = Discount.create!(company_id: company.id, payment_method_id: payment_method.id, discount_percentage:5)
      charge1 = Charge.create!(company_id: company.id, product_id: product.id, payment_method_id: payment_method.id,
                              client_id: client1.id, discount_id: discount.id, card_name: 'MATHEUS O VIEIRA',
                              card_number: '1234567890123456', card_code: '789', original_price: product.price,
                              new_price: 28.5, expiration_date:'30/06/2021', status: 'pendente')
      charge2 = Charge.create!(company_id: company.id, product_id: product.id, payment_method_id: payment_method.id,
                              client_id: client2.id, discount_id: discount.id, card_name: 'GABRIELA O VIEIRA',
                              card_number: '9876543210987654', card_code: '654', original_price: product.price,
                              new_price: 28.5, expiration_date:'01/07/2021', status: 'pendente')
      charge2 = Charge.create!(company_id: company.id, product_id: product.id, payment_method_id: payment_method.id,
                              client_id: client3.id, discount_id: discount.id, card_name: 'JUCELINO O VIEIRA',
                              card_number: '7418529630741085', card_code: '012', original_price: product.price,
                              new_price: 28.5, expiration_date:'01/07/2021', status: 'pendente')

      get '/api/v1/search_by_expiration_date', params: 
      {
        q: charge2.expiration_date
      } 
      
      
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      expect(parsed_body[0]['card_name']).to eq('GABRIELA O VIEIRA')
      expect(parsed_body[0]['card_number']).to eq('9876543210987654')
      expect(parsed_body[1]['card_name']).to eq('JUCELINO O VIEIRA')
      expect(parsed_body[1]['card_number']).to eq('7418529630741085')
    end

    it'search by payment method' do
      company = Company.create!(name: 'TeachTech', cnpj: '92107397000133', address: 'Rua A 123', email: 'contato@teachtech.com')
      product = Product.create!(name: 'Curso de Ruby on Rails', price: 30, company_id: company.id)
      payment_credit = Payment.create!(name: 'Dev Card', type_payment: 'credito', fee_percentage: '1.2', max_fee: '50', active: true, bank_code: '000')
      payment_boleto = Payment.create!(name: 'Banco Ximira', type_payment: 'boleto', fee_percentage: '1.1', max_fee: '30', active: true, bank_code: '987')
      payment_method1 = PaymentMethod.create!(payment_id: payment_credit.id, company_id: company.id, code: 'qweasdzxc123poi098lk')
      payment_method2 = PaymentMethod.create!(payment_id: payment_boleto.id, company_id: company.id, agency: '123', bank_account: '1234-5')
      client1 = Client.create!(name: 'Matheus Oliveira', cpf: '12312312512')
      client2 = Client.create!(name: 'Gabriela Oliveira', cpf: '12312312512')
      client3 = Client.create!(name: 'Jucelino Oliveira', cpf: '12312312512')
      discount1 = Discount.create!(company_id: company.id, payment_method_id: payment_method1.id, discount_percentage:5)
      discount2 = Discount.create!(company_id: company.id, payment_method_id: payment_method2.id, discount_percentage:5)
      charge1 = Charge.create!(company_id: company.id, product_id: product.id, payment_method_id: payment_method1.id,
                              client_id: client1.id, discount_id: discount1.id, card_name: 'MATHEUS O VIEIRA',
                              card_number: '1234567890123456', card_code: '789', original_price: product.price,
                              new_price: 28.5, expiration_date:'30/06/2021', status: 'pendente')
      charge2 = Charge.create!(company_id: company.id, product_id: product.id, payment_method_id: payment_method2.id,
                              client_id: client2.id, discount_id: discount2.id, boleto_address: 'Rua B 234', original_price: product.price,
                              new_price: 28.5, expiration_date:'01/07/2021', status: 'pendente')
      charge2 = Charge.create!(company_id: company.id, product_id: product.id, payment_method_id: payment_method2.id,
                              client_id: client3.id, discount_id: discount2.id, boleto_address: 'Rua C 345', original_price: product.price,
                              new_price: 28.5, expiration_date:'01/07/2021', status: 'pendente')

      get '/api/v1/search_by_payment_method', params: 
      {
        q: payment_method1.id
      } 
      
      
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      expect(parsed_body[0]['card_name']).to eq('MATHEUS O VIEIRA')
      expect(parsed_body[0]['card_number']).to eq('1234567890123456')
      
    end
  end
end