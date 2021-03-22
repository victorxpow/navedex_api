require 'rails_helper'

RSpec.describe 'Navers', type: :request do
  let!(:user) { create(:user) }
  let!(:navers) { create_list(:naver, 10, user: user) }

  let(:valid_params) do
    {
      user: {
        email: user.email,
        password: user.password
      }
    }
  end
  
  before do
    post '/api/v1/users/sign_in', params: valid_params
  end
  
  let(:token) { { Authorization: response.headers['Authorization'] } }
  
  describe 'GET /api/v1/navers' do

    context 'when params are correct' do
      before do
        post '/api/v1/users/sign_in', params: valid_params
      end

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
  end

  # Test suite for POST /api/v1/navers

  describe 'POST /api/v1/navers' do
    context 'when params are correct' do
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

      it 'creates a naver with projects' do
        project = create(:project, name: 'Improving Sales BG')
        other_project = create(:project)

        valid_params = attributes_for(:naver, name: 'Yusuke Urameshi', birthdate: '1999-05-15', admission_date: '2020-06-12',
                                              job_role: 'Desenvolvedor', projects: [project.id, other_project.id])

        post '/api/v1/navers', params: valid_params, headers: token
        json = JSON.parse(response.body).symbolize_keys
        expect(json[:name]).to eq('Yusuke Urameshi')
        expect(json[:birthdate]).to eq('1999-05-15')
        expect(json[:admission_date]).to eq('2020-06-12')
        expect(json[:job_role]).to eq('Desenvolvedor')
        expect(json[:projects].size).to eq(2)
      end
    end

    context 'fail' do
      let(:params) { {} }

      it 'missing params' do
        post '/api/v1/navers', params: params, headers: token
        expect(response).to have_http_status :unprocessable_entity
      end
    end

    context 'when are not authenticated' do
      before { post '/api/v1/navers', params: { title: 'Foobar' } }

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  # Test suite for GET /api/v1/navers/:id
  describe 'GET /api/v1/navers/:id' do
    context 'when the record exists' do
      it 'returns the naver' do
        project = create(:project)
        other_project = create(:project)
        naver = create(:naver, user: user, projects: [project, other_project])
        get "/api/v1/navers/#{naver.id}", headers: token

        json = JSON.parse(response.body).symbolize_keys

        expect(json).not_to be_empty
        expect(json[:id]).to eq(naver.id)
        expect(json[:name]).to eq(naver.name)
        expect(json[:birthdate]).to eq(naver.birthdate.strftime('%Y-%m-%d'))
        expect(json[:admission_date]).to eq(naver.admission_date.strftime('%Y-%m-%d'))
        expect(json[:job_role]).to eq(naver.job_role)
        expect(json[:projects].size).to eq(2)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:naver_id) { 999 }
      it 'returns status code 404' do
        get "/api/v1/navers/#{naver_id}", headers: token
        expect(response).to have_http_status(404)
      end
    end

    context 'when are not authenticated' do
      let(:naver_id) { 999 }
      it 'returns status code 401' do
        get "/api/v1/navers/#{naver_id}"
        expect(response).to have_http_status(401)
      end
    end
  end

  # Test suite for PUT /api/v1/navers/:id
  describe 'PUT /api/v1/navers/:id' do
    let(:valid_attributes) do
      attributes_for(:naver, name: 'Yusuke Urameshi', birthdate: '1999-05-15', admission_date: '2020-06-12',
                             job_role: 'Desenvolvedor')
    end

    context 'when the record exists' do
      it 'updates the record' do
        naver = create(:naver, user: user)
        put "/api/v1/navers/#{naver.id}", params: valid_attributes, headers: token
        json = JSON.parse(response.body)
        expect(json['name']).to eq('Yusuke Urameshi')
        expect(json['birthdate']).to eq('1999-05-15')
        expect(json['admission_date']).to eq('2020-06-12')
        expect(json['job_role']).to eq('Desenvolvedor')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'fail' do
      let(:params) { attributes_for(:naver, admission_date: 456, user: 2) }

      it 'missing params' do
        naver = create(:naver, user: user)
        other_naver = create(:naver, user: user)
        put "/api/v1/navers/#{other_naver.id}", params: params, headers: token
        expect(response).to have_http_status :unprocessable_entity
      end
    end

    context 'when are not authenticated' do
      it 'returns status code 401' do
        naver = create(:naver, user: user)
        put "/api/v1/navers/#{naver.id}"
        expect(response).to have_http_status(401)
      end
    end
  end

  # Test suite for DELETE /api/v1/navers/:id
  describe 'DELETE /api/v1/navers/:id' do
    context 'when the record exists' do
      it 'returns status code 204' do
        naver = create(:naver, user: user)
        delete "/api/v1/navers/#{naver.id}", headers: token
        expect(response).to have_http_status(204)
      end
    end

    context 'when are not authenticated' do
      it 'returns status code 401' do
        naver = create(:naver, user: user)
        delete "/api/v1/navers/#{naver.id}"
        expect(response).to have_http_status(401)
      end
    end
  end
end
