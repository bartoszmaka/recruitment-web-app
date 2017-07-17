require 'rails_helper'

RSpec.describe Interest, type: :model do
  context 'associations' do
    it 'belongs to user' do
      user = User.create(email: 'something@foo.com', password: 'foobar123', gender: 'male', age: 55)
      interest = Interest.create(name: 'doing something', interest_type: 'health', user: user)

      expect(interest.user).to eq user
    end
  end

  context 'validations' do
    it 'requires name to exist' do
      interest = Interest.new(name: '', interest_type: 'hobby')

      expect(interest.valid?).to be false
      expect(interest.errors.details[:name].empty?).to be false
    end

    it 'requires interest type to exist' do
      interest = Interest.new(name: 'testing validations', interest_type: nil)

      expect(interest.valid?).to be false
      expect(interest.errors.details[:interest_type].empty?).to be false
    end
  end
end
