require 'rails_helper'

RSpec.describe RegardsController, type: :controller do
  describe 'post #create' do
    it 'redirects to users path' do
      post :create

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to users_path
    end
  end
end
