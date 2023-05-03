require 'rails_helper'

RSpec.describe 'Operations', type: :request do
  include Warden::Test::Helpers

  before do
    @user = User.new(name: 'John Doe', email: 'john_doe@test.com', password: 'test_pass')
    login_as @user, scope: :user
    @group = Group.create!(name: 'Food', user: @user)
    @op1 = Operation.create!(name: 'McDonalds', amount: 12.99, author: @user.name, user: @user, groups: [@group])
    @op2 = Operation.create!(name: 'Wendy\'s', amount: 15.25, author: @user.name, user: @user)
  end
  describe 'GET #index' do
    before do
      get group_operations_path(@group)
    end

    it 'should have a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'should render the correct page' do
      expect(response.body).to include(@group.name)
    end

    it 'should include total amount' do
      expect(response.body).to include(@group.value.to_s)
    end

    it 'should render operations correctly' do
      expect(response.body).to include('McDonalds')
      expect(response.body).to_not include('Wendy\'s')
    end
  end

  describe 'GET #new' do
    before do
      get new_group_operation_path(@group)
    end

    it 'should have a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'should render the correct page' do
      expect(response.body).to include('NEW OPERATION')
      expect(response.body).to include('Operation name')
      expect(response.body).to include('Operation amount')
      expect(response.body).to include(@group.name)
    end
  end
end
