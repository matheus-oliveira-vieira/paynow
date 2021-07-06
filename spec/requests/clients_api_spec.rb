require 'rails_helper'

describe 'Clients API' do
  context 'GET /api/v1/clients' do
    it 'should get clients' do
      Client.create!(name: 'Matheus Oliveira', cpf: '12312312512')
      Client.create!(name: 'Gleica Oliveira', cpf: '12312312512')

      get '/api/v1/clients'

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      expect(parsed_body.count).to eq(Client.count)
      expect(parsed_body[0]['name']).to eq('Matheus Oliveira')
      expect(parsed_body[1]['name']).to eq('Gleica Oliveira')
    end
  end
  context 'PATCH /api/v1/clients/:client_id/generate_token' do
    it 'should generate token' do
      client = Client.create!(name: 'Matheus Oliveira', cpf: '12312312512')

      patch "/api/v1/clients/#{client.id}/generate_token"

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      # byebug
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['name']).to eq('Matheus Oliveira')
    end
  end
end
