require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  describe 'POST #create' do
    context 'sucessfully' do
      let(:valid_params) {{ user: { email: 'test@teste.com', password: '123456'} }}

      
      it 'response with created' do
        expect { post "/api/v1/users", params: valid_params }.to change(User, :count).by(+1)
        expect(response).to have_http_status :created
      end
    end

    context 'fail' do
      let(:params) { {} }

      it 'missing params' do
        post "/api/v1/users", params: params
        expect(response).to have_http_status :unprocessable_entity
      end
    end
end
end
