require 'rails_helper'

RSpec.describe 'Navers', type: :request do
  let!(:user) { create(:user) }
  let!(:navers) { create_list(:naver, 10, user: user) }

  describe 'GET /navers' do
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
      let(:token) { { Authorization: response.headers['Authorization'] } }

      it 'returns navers' do
        get '/api/v1/navers', headers: token
        json = JSON.parse(response.body)
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      context 'when are not authenticated' do
        it 'returns status code 401' do
          get '/api/v1/navers'
          expect(response).to have_http_status(401)
        end
      end
    end

    # Test suite for POST /articles

    describe 'POST /articles' do
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
        let(:token) { { Authorization: response.headers['Authorization'] } }

        let(:valid_attributes) do
          attributes_for(:naver, name: 'Yusuke Urameshi', birthdate: '1999-05-15', admission_date: '2020-06-12',
                                 job_role: 'Desenvolvedor')
        end

        before { post '/api/v1/navers', params: valid_attributes, headers: token }

        it 'creates a naver' do
          json = JSON.parse(response.body)
          expect(json['name']).to eq('Yusuke Urameshi')
          expect(json['birthdate']).to eq('1999-05-15')
          expect(json['admission_date']).to eq('2020-06-12')
          expect(json['job_role']).to eq('Desenvolvedor')
        end

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end
      end

      context 'when are not authenticated' do
        before { post '/api/v1/navers', params: { title: 'Foobar' } }

        it 'returns status code 401' do
          expect(response).to have_http_status(401)
        end
      end
    end
  end
end
