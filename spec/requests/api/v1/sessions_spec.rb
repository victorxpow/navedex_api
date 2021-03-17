require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:valid_params) do
      {
        user: {
          email: user.email,
          password: user.password
        }
      }
    end

    context 'when params are correct' do
      before do
        post '/api/v1/users/sign_in', params: valid_params
      end

      it 'returns 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns JTW token in authorization header' do
        expect(response.headers['Authorization']).to be_present
      end
    end

    context 'when login params are incorrect' do
      before { post '/api/v1/users/sign_in' }

      it 'returns invalid email or password' do
        expect(response.status).to eq 401
      end
    end
  end
end
