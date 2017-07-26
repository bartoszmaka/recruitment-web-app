require 'rails_helper'

RSpec.describe CsvParser do
  before(:each) { create_users }
  let(:result) { CsvParser.execute(User.all) }

  it 'outputs csv string with given uses' do
    expect(result.class).to be String
  end

  it 'has one user data per line' do
    expect(result.lines.count).to eq(User.count + 1)
  end
end

def create_users
  5.times do |i|
    user = User.create(email: "rspecer#{i}@rspec.com", age: rand(100), gender: rand(2), password: '123123')
    rand(1..4).times do |j|
      user.interests.create(name: "doing #{i}#{j} things at once", interest_type: rand(3))
    end
  end
end
