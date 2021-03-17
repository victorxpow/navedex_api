require 'rails_helper'

RSpec.describe "Navers", type: :request do
let!(:user) { create(:user) }
let!(:navers) { create_list(:naver, 10, user: user) }

describe 'GET /navers' do
  before { get '/api/v1/navers' }

  it 'returns navers' do
    json = JSON.parse(response.body)
    expect(json).not_to be_empty
    expect(json.size).to eq(10)
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(200)
  end
end
end
