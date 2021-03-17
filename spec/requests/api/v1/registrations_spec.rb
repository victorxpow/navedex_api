require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  describe 'POST #create' do
    let(:user) { build(:user) }
    let(:valid_params) do
      {
        user: {
          email: user.email,
          password: user.password
        }
      }
    end

    context 'sucessfully' do
      it 'response with created' do
        expect { post '/api/v1/users', params: valid_params }.to change(User, :count).by(+1)
        expect(response).to have_http_status :created
      end
    end

    context 'fail' do
      let(:params) { {} }

      it 'missing params' do
        post '/api/v1/users', params: params
        expect(response).to have_http_status :unprocessable_entity
      end
    end

    context 'when user already exists' do
      let(:user) { create(:user) }
      before do
        post '/api/v1/users', params: valid_params
      end

      it 'returns unprocessable entity status' do
        expect(response.status).to eq 422
      end
    end
  end
end
