require 'rails_helper'

RSpec.describe 'Groups', type: :request do
  include Warden::Test::Helpers

  before do
    @user = User.new(name: 'John Doe', email: 'john_doe@test.com', password: 'test_pass')
    login_as @user, scope: :user
    @group = Group.create!(name: 'Food', user: @user)
  end
  describe 'GET #index' do
    before do
      get groups_path
    end

    it 'should have a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'should render the correct page' do
      expect(response.body).to include('CATEGORIES')
    end

    it 'should render groups correctly' do
      expect(response.body).to include('Food')
    end
  end

  describe 'GET #new' do
    before do
      get new_group_path
    end

    it 'should have a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'should render the correct page' do
      expect(response.body).to include('NEW CATEGORY')
      expect(response.body).to include('Name')
    end
  end
end
