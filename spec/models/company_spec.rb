require 'rails_helper'

  describe Company do
    context 'token' do
      it 'generate a random token when creating' do
        company = create(:company)
        expect(company.token).to be_present
      end

      it 'generate another token if repeats' do
        company = create(:company)
        another_company = build(:company)
        allow(SecureRandom).to receive(:hex).and_return(company.token, 'f1DoB2djcqMmEcx4qCtm')
        another_company.save
        expect(company.token).not_to eq(another_company.token)
      end
  end

end
