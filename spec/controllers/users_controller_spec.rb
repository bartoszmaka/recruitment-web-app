require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { User.create(email: 'rspec@rspec.com', password: 'rspec12') }
  let(:other_user) { User.create(email: 'rails@rspec.com', password: 'rails12') }
  context 'user is authenticated' do
    before(:each) do
      sign_in user
      get :index
    end

    it 'assigns users' do
      expect(assigns(:users)).to match([user, other_user])
    end

    it 'renders index template' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  context 'user is not authenticated' do
    before(:each) do
      get :index
    end

    it 'redirects to login page' do
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to new_user_session_path
    end
  end
end
