require 'rails_helper'

RSpec.describe 'Users', type: :request do
  include Warden::Test::Helpers

  before do
    @user = User.new(name: 'John Doe', email: 'john_doe@test.com', password: 'test_pass')
    login_as @user, scope: :user
  end
  describe 'GET #index' do
    it 'should have a successful response' do
      get '/user'
      expect(response).to have_http_status(:success)
    end
  end
end
