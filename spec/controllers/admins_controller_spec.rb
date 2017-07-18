require 'rails_helper'

RSpec.describe AdminsController, type: :controller do
  let(:admin) { User.create(email: 'admin@rspec.com', password: 'rspec12', admin: true, gender: 'female', age: 11) }
  let(:user) { User.create(email: 'user@rspec.com', password: 'rspec12', gender: 'female', age: 11) }

  describe 'get #index' do
    context 'user is an admin' do
      before(:each) do
        sign_in admin
        get :index
      end

      it 'renders page' do
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:index)
      end
    end

    context 'user is not an admin' do
      before(:each) do
        sign_in user
        get :index
      end

      it 'redirects to other page' do
        expect(response).to have_http_status(:found)
      end
    end

    context 'user is not logged in' do
      before(:each) do
        get :index
      end

      it 'redirects to other page' do
        expect(response).to have_http_status(:found)
      end
    end
  end
end
