require 'rails_helper'

RSpec.describe Interest, type: :model do
  context 'validations' do
    it 'requires name to be exist' do
      interest = Interest.new(name: '')

      expect(interest.valid?).to be false
      expect(interest.errors.details[:name].empty?).to be false
    end
  end
end
