require 'rails_helper'

RSpec.describe 'users V1 API', type: :request do

    #initialize test data

    let!(:users) {create_list(:user, 10)}
    let(:user_id) { users.first.id }

    # Test suite for GET /users
    describe 'GET /api/v1/users' do
        # make HTTP get request before each example
        before { get '/api/v1/users' }

        it 'returns users' do
        # Note `json` is a custom helper to parse JSON responses
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
        end

        it 'returns status code 200' do
        expect(response).to have_http_status(200)
        end
    end


  # Test suite for GET /api/v1/users/:id
  describe 'GET /api/v1/users/:id' do
    before { get "/api/v1/users/#{user_id}" }

    context 'when the record exists' do
      it 'returns the user' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match("{\"message\":\"Couldn't find User with 'id'=100\"}")
      end
    end
  end    

end