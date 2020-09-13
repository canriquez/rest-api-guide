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


    # Test suite for POST /api/v1/users
    describe 'POST /api/v1/users' do
        # valid payload
        let(:valid_attributes) { { username: 'Learn Elm', password: 'lorem' } }
    
        context 'when the request is valid' do
          before { post '/api/v1/users', params: valid_attributes }
    
          it 'creates a user' do
            expect(json['username']).to eq('Learn Elm')
            expect(json['password']).to eq('lorem')
          end
    
          it 'returns status code 201' do
            expect(response).to have_http_status(201)
          end
        end
    
        context 'when the request is invalid' do
          before { post '/api/v1/users', params: { username: 'Foobar' } }
    
          it 'returns status code 422' do
            expect(response).to have_http_status(422)
          end
    
          it 'returns a validation failure message' do
            expect(response.body)
              .to match("{\"message\":\"Validation failed: Password can't be blank\"}")
          end
        end
      end

    # Test suite for PUT /api/v1/users/:id
    describe 'PUT /api/v1/users/:id' do
        let(:valid_attributes) { { username: 'Shopping' } }

        context 'when the record exists' do
        before { put "/api/v1/users/#{user_id}", params: valid_attributes }

        it 'updates the record' do
            expect(response.body).to be_empty
        end

        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end
        end
    end

end