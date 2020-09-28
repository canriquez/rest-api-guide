=begin 
require 'rails_helper'


RSpec.describe 'users V1 API', type: :routing do

  describe 'login / auto_login routing' do
    it 'routes /login to users#login login route' do
      expect(:post => '/api/v1/login').to route_to('api/v1/users#login')
    end
  end

  describe 'login / auto_login routing' do
    it 'routes /login to users#login login route' do
      expect(:get => '/api/v1/auto_login').to route_to('api/v1/users#auto_login')
    end
  end
end
=end