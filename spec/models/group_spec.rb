require 'rails_helper'

RSpec.describe Group, type: :model do
  include Warden::Test::Helpers

  subject do
    @user = User.new(name: 'John Doe', email: 'john_doe@test.com', password: 'test_pass')
    login_as 'a user', scope: :user
    Group.create!(name: 'Food', user: @user)
  end

  after { Warden.test_reset! }

  context 'validation' do
    it 'should create a group with the correct parameters' do
      expect(subject).to be_valid
    end

    it 'should not be valid with empty name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'should not be valid without a user' do
      subject.user = nil
      expect(subject).to_not be_valid
    end

    it 'should have an image attached' do
      expect(subject.image.attached?).to be_truthy
    end
  end
end