require 'rails_helper'

RSpec.describe Interest, type: :model do
  context 'validations' do
    it 'requires name to be unique' do
      Interest.create(name: 'doing something')
      interest = Interest.new(name: 'doing SOMETHING')

      expect(interest.valid?).to be false
      expect(interest.errors.details[:name].empty?).to be false
    end
  end
end
