require 'rails_helper'

RSpec.describe 'Projects', type: :request do
  let!(:user) { create(:user) }
  let!(:projects) { create_list(:project, 10) }

  describe 'GET /api/v1/projects' do
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

      it 'returns projects' do
        get '/api/v1/projects', headers: token
        json = JSON.parse(response.body)
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      context 'when are not authenticated' do
        it 'returns status code 401' do
          get '/api/v1/projects'
          expect(response).to have_http_status(401)
        end
      end
    end
  end

  # Test suite for POST /api/v1/projects

  describe 'POST /api/v1/projects' do
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

    context 'when params are correct' do
      let(:valid_attributes) { attributes_for(:project, name: 'Desconstrução de monolito') }

      before { post '/api/v1/projects', params: valid_attributes, headers: token }

      it 'creates a project' do
        json = JSON.parse(response.body)
        expect(json['name']).to eq('Desconstrução de monolito')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'creates a project with naver' do
        naver = create(:naver, name: 'Yusuke Urameshi', birthdate: '1999-05-15', admission_date: '2020-06-12',
                               job_role: 'Desenvolvedor', user: user)

        valid_params = attributes_for(:project, name: 'Improving Sales BG', navers: [naver.id])

        post '/api/v1/projects', params: valid_params, headers: token
        json = JSON.parse(response.body).symbolize_keys
        expect(json[:name]).to eq('Improving Sales BG')
      end
    end

    context 'fail' do
      let(:params) { {} }

      it 'missing params' do
        post '/api/v1/projects', params: params, headers: token
        expect(response).to have_http_status :unprocessable_entity
      end
    end

    context 'when are not authenticated' do
      before { post '/api/v1/projects', params: { title: 'Foobar' } }

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  # Test suite for GET /api/v1/projects/:id
  describe 'GET /api/v1/projects/:id' do
    # Auth

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

    context 'when the record exists' do
      it 'returns the project' do
        project = create(:project)
        get "/api/v1/projects/#{project.id}", headers: token

        json = JSON.parse(response.body)
        expect(json).not_to be_empty
        expect(json['id']).to eq(project.id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:project_id) { 999 }
      it 'returns status code 404' do
        get "/api/v1/projects/#{project_id}", headers: token
        expect(response).to have_http_status(404)
      end
    end

    context 'when are not authenticated' do
      let(:project_id) { 999 }
      it 'returns status code 401' do
        get "/api/v1/projects/#{project_id}"
        expect(response).to have_http_status(401)
      end
    end
  end

  # Test suite for PUT /api/v1/projects/:id
  describe 'PUT /api/v1/projects/:id' do
    # Auth

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
    let(:valid_attributes) { attributes_for(:project, name: 'Desconstrução de monolito') }

    context 'when the record exists' do
      it 'updates the record' do
        project = create(:project)
        put "/api/v1/projects/#{project.id}", params: valid_attributes, headers: token
        json = JSON.parse(response.body)
        expect(json['name']).to eq('Desconstrução de monolito')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'fail' do
      let(:params) { attributes_for(:project, name: 'Improving the coverage') }

      it 'missing params' do
        project = create(:project, name: 'Improving the coverage')
        other_project = create(:project)
        put "/api/v1/projects/#{other_project.id}", params: params, headers: token
        expect(response).to have_http_status :unprocessable_entity
      end
    end

    context 'when are not authenticated' do
      it 'returns status code 401' do
        project = create(:project)
        put "/api/v1/projects/#{project.id}"
        expect(response).to have_http_status(401)
      end
    end
  end

  # Test suite for DELETE /api/v1/projects/:id
  describe 'DELETE /api/v1/projects/:id' do
    # Auth

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

    it 'returns status code 204' do
      project = create(:project)
      delete "/api/v1/projects/#{project.id}", headers: token
      expect(response).to have_http_status(204)
    end

    context 'when are not authenticated' do
      it 'returns status code 401' do
        project = create(:project)
        delete "/api/v1/projects/#{project.id}"
        expect(response).to have_http_status(401)
      end
    end
  end
end
