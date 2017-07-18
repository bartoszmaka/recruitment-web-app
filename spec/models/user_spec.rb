require 'rails_helper'

RSpec.describe User, type: :model do
  context 'associations' do
    it 'has many interests' do
      user = User.create(email: 'something@foo.com', password: 'foobar123', gender: 'male', age: 55)
      interest1 = user.interests.create(name: 'writing specs', interest_type: 'hobby')
      interest2 = Interest.create(name: 'doing something', interest_type: 'health', user: user)

      expect(user.interests).to match [interest1, interest2]
    end
  end

  context 'validations' do
    it 'requires email to be unique' do
      User.create(email: 'rspec@rspec.com', password: 'rspec12', gender: 'male', age: '55')
      user = User.new(email: 'RSPEC@rspec.com', password: 'rspec12', gender: 'male', age: '55')

      expect(user.valid?).to be false
      expect(user.errors.details[:email].empty?).to be false
    end

    it 'requires strong password' do
      user = User.new(email: 'rspec@rspec.com', password: '12', gender: 'male', age: '55')

      expect(user.valid?).to be false
      expect(user.errors.details[:password].empty?).to be false
    end

    it 'requires age to exist' do
      user = User.new(email: 'rspec@rspec.com', password: 'rspec12', gender: 'male', age: nil)

      expect(user.valid?).to be false
      expect(user.errors.details[:age].empty?).to be false
    end

    it 'requires age to be between 0 and 100' do
      user1 = User.new(email: 'rspec@rspec.com', password: 'rspec12', gender: 'male', age: -50)
      user2 = User.new(email: 'rspec@rspec.com', password: 'rspec12', gender: 'male', age: 500)

      expect(user1.valid?).to be false
      expect(user2.valid?).to be false
    end

    it 'requires gender to exist' do
      user = User.new(email: 'rspec@rspec.com', password: 'rspec12', gender: nil, age: '55')

      expect(user.valid?).to be false
      expect(user.errors.details[:gender].empty?).to be false
    end
  end
end
