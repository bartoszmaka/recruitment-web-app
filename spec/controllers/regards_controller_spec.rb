require 'rails_helper'

RSpec.describe RegardsController, type: :controller do
  let(:admin) { User.create(email: 'admin@rspec.com', password: 'rspec12', admin: true, gender: 'female', age: 11) }
  let(:user) { User.create(email: 'user@rspec.com', password: 'rspec12', gender: 'female', age: 11) }
  let(:call_request) { post :create, params: { id: user.id } }

  describe 'post #create' do
    before(:each) do
      sign_in admin
      allow(RegardsSender).to receive(:execute)
      call_request
    end

    it 'redirects to users path' do
      expect(call_request).to have_http_status(:found)
      expect(call_request).to redirect_to users_path
    end

    it 'calls RegardsSender service' do
      expect(RegardsSender).to have_received(:execute)
    end
  end
end
