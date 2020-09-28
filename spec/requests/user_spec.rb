=begin 
require 'rails_helper'

# User information request: this should fail when not authorised
# it is still not failing.
describe 'GET /api/v1/users' do
    let!(:user) {FactoryBot.create(:user)}

    before {get '/api/v1/users', headers: auth_headers(user)}

    it 'returns HTTP status 200' do
        expect(response).to have_http_status 200
    end

    it 'returns all users' do
        body = JSON.parse(response.body)
        p body.first
        expect(json_response.size).to eq(1)
      end
end

# User Login authentication test
# it is still not failing.
describe 'GET /api/v1/users/login' do
    let!(:user) {FactoryBot.create(:user)}

    before {get '/api/v1/login', headers: auth_headers(user)}

    it 'returns HTTP status 200' do
        expect(response).to have_http_status 200
    end

    it 'returns all users' do
        body = JSON.parse(response.body)
        p body.first
        expect(json_response.size).to eq(1)
      end
end 
=end