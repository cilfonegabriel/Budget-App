require 'rails_helper'

RSpec.describe User, type: :model do
  include Warden::Test::Helpers

  subject do
    User.new(name: 'John Doe', email: 'john_doe@test.com', password: 'test_pass')
  end

  before { subject.save }
  after { Warden.test_reset! }

  context 'validation' do
    it 'Should create a user with valid parameters' do
      expect(subject).to be_valid
    end

    it 'should not be valid with empty name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'should not be valid with empty email' do
      subject.email = nil
      expect(subject).to_not be_valid
    end
    it 'password should be at least 6 characters long' do
      subject.password = '123'
      expect(subject).to_not be_valid
      subject.password = '123123'
      expect(subject).to be_valid
    end
  end
end
