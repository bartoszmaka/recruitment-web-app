require 'rails_helper'

RSpec.describe RegardsController, type: :controller do
  let(:user) { User.create(email: 'rails@rails.com', password: 'rails', age: 1, gender: 'male') }
  let(:other_user) { User.create(email: 'rspec@rspec.com', password: 'rspec12', age: 1, gender: 'male') }

  describe 'post #create' do
    it 'redirects to users path' do
      post :create

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to users_path
    end
  end
end
