require 'rails_helper'

RSpec.describe Operation, type: :model do
  include Warden::Test::Helpers

  subject do
    @user = User.new(name: 'John Doe', email: 'john_doe@test.com', password: 'test_pass')
    login_as 'a user', scope: :user
    Group.create!(name: 'Food', user: @user)
    Operation.create!(name: 'McDonalds', amount: 12.99, author: @user.name, user: @user)
  end

  after { Warden.test_reset! }

  context 'validation' do
    it 'Should create an operation with valid parameters' do
      expect(subject).to be_valid
    end

    it 'should not be valid with empty name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'should not be valid with empty author' do
      subject.author = nil
      expect(subject).to_not be_valid
    end

    it 'should not be valid with empty amount' do
      subject.amount = nil
      expect(subject).to_not be_valid
    end

    it 'author should be John Doe' do
      expect(subject.author).to eq('John Doe')
    end

    it 'name should be McDonalds' do
      expect(subject.name).to eq('McDonalds')
    end

    it 'amount should be 12.99' do
      expect(subject.amount).to eq(12.99)
    end
  end
end
