require 'rails_helper'

RSpec.describe 'token generation at api/v1', type: :request do

    let!(:bot) { FactoryBot.create(:user, username: 'bot',  password: '12345') }
    let!(:valid_user) { { username: 'bot', password: '12345' } }    
    let!(:invalid_user) { { username: 'bot', password: '' } }   


     # Test suite for POST /api/v1/users
     describe 'should get JWT token' do

        context 'when the user exists ' do
            before { post '/api/v1/tokens', params: valid_user }

            it 'returns a valid user' do
                expect(json['user']['username']).to eq('bot')
            end

            it 'confirms token presence on response' do
                expect(json['token']).not_to be_nil
            end
        end

        context 'when the user does not exists ' do
            before { post '/api/v1/tokens', params: invalid_user }

            it 'returns a error message' do
                expect(response.body)
                .to match("{\"error\":\"Wrong username or pass\"}")
            end

            it 'confirms token nil on response' do
                expect(json['token']).to be_nil
            end
        end

     end



end