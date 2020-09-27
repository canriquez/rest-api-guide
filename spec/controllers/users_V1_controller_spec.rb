require 'rails_helper'

RSpec.describe 'users V1 API', type: :request do

    #initialize test data

    let!(:users) {create_list(:user, 1)}
    let!(:bot) { FactoryBot.create(:user, username: 'bot',  password: 'lorem') }
    let!(:user_id) { bot.id }

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
        let(:valid_attributes) { { username: 'LearnElm1', password: 'lorem' } }    
        context 'when the request is valid' do
          before { post '/api/v1/users', params: valid_attributes }
    
          it 'creates a user' do
            expect(json['user']['username']).to eq('LearnElm1')
          end
    
          it 'returns status code 200' do
            expect(response).to have_http_status(200)
          end
        end

        context 'it should fail when user name is repeated' do
          before { post '/api/v1/users', params: { username: 'bot', password: 'lorem' } }
    
          it 'returns status code 422' do
            p response.body
            expect(response).to have_http_status(422)
          end
    
          it 'returns a validation failure message' do
            expect(response.body)
              .to match("{\"user\":{\"username\":[\"has already been taken\"]}}")
          end
        end
    
        context 'it should fail when password is missing' do
          before { post '/api/v1/users', params: { username: 'Foobar' } }
    
          it 'returns status code 422' do
            expect(response).to have_http_status(422)
          end
    
          it 'returns a validation failure message' do
            expect(response.body)
              .to match("{\"user\":{\"password\":[\"can't be blank\"]}}")
          end
        end
      end

    # Test suite for PATCH /api/v1/users/:id
    describe 'PATCH /api/v1/users/:id' do
        let(:valid_attributes) { { username: 'newbot', password: '123456' } }
        let(:invalid_attributes) { { username: 'bot' } }

        context 'when the record exists and valid attributes' do
          before { patch "/api/v1/users/#{user_id}", params: valid_attributes }

          it 'updates user name' do
            expect(json['user']['username']).to eq('newbot')
          end

          it 'returns status code 200' do
              expect(response).to have_http_status(200)
          end

        end

        context 'when the record exists and invalid attributes' do
          before { patch "/api/v1/users/#{user_id}", params: invalid_attributes }

          it 'fails to update the record' do
            expect(response.body)
            .to match("{\"password\":[\"can't be blank\"]}")
          end

          it 'returns status code 422' do
              expect(response).to have_http_status(422)
          end
        end
    end


    # Test suite for DELETE /api/v1/users/:id
    describe 'DELETE /api/v1/users/:id' do
        before { delete "/api/v1/users/#{user_id}" }

        it 'should destroy user' do
        expect(response).to have_http_status(204)
        end
    end

end