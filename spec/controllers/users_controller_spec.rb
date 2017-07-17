require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:admin) { User.create(email: 'admin@rspec.com', password: 'rspec12', admin: true, age: 1, gender: 'male') }
  let(:user) { User.create(email: 'rspec@rspec.com', password: 'rspec12', age: 1, gender: 'male') }
  let(:other_user) { User.create(email: 'rails@rspec.com', password: 'rails12', age: 1, gender: 'male') }
  let(:user_attributes) { { email: 'newuser@rspec.com', password: 'rspec12', age: 2, gender: 'female' } }

  describe 'get #index' do
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

  describe 'get #new' do
    context 'user is an admin' do
      before(:each) do
        sign_in admin
        get :new
      end

      it 'assigns new user' do
        expect(assigns(:user).attributes).to eq User.new.attributes
      end

      it 'renders new template' do
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
      end
    end

    context 'user is not an admin' do
      before(:each) do
        sign_in user
        get :new
      end

      it 'redirects to root page' do
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'get #edit' do
    context 'user is an admin' do
      before(:each) do
        user
        sign_in admin
        get :edit, params: { id: user.id }
      end

      it 'assigns user' do
        expect(assigns(:user)).to eq user
      end

      it 'renders edit template' do
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:edit)
      end
    end

    context 'user is not an admin' do
      before(:each) do
        admin
        sign_in user
        get :edit, params: { id: admin.id }
      end

      it 'redirects to root page' do
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'post #create' do
    context 'user is an admin' do
      before(:each) { sign_in admin }

      context 'params are valid' do
        before(:each) do
          post :create, params: { user: user_attributes }
        end

        it 'creates new user' do
          expect(User.last.email).to eq user_attributes[:email]
        end

        it 'redirects to admin panel' do
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(admins_path)
        end
      end

      context 'params are invalid' do
        before(:each) { post :create, params: { user: { email: 'nonsense' } } }

        it 'does not create an user' do
          expect(User.last.email).not_to eq 'nonsense'
        end

        it 'renders new template' do
          expect(response).to have_http_status(:ok)
          expect(response).to render_template(:new)
        end
      end
    end

    context 'when user is not an admin' do
      before(:each) do
        sign_in user
        post :create, params: { user: user.attributes }
      end

      it 'redirects to root page' do
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'patch #update' do
    context 'user is an admin' do
      before(:each) do
        user
        sign_in admin
      end

      context 'params are valid' do
        before(:each) do
          patch :update, params: { id: user.id, user: { email: 'mynewvalidemail@rspec.com' } }
        end

        it 'updates user' do
          expect(User.find(user.id).email).to eq 'mynewvalidemail@rspec.com'
        end

        it 'redirects to admin panel' do
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(admins_path)
        end
      end

      context 'params are invalid' do
        before(:each) { patch :update, params: { id: user.id, user: { email: 'nonsense' } } }

        it 'does not update user' do
          expect(User.last.email).not_to eq 'nonsense'
        end

        it 'renders edit template' do
          expect(response).to have_http_status(:ok)
          expect(response).to render_template(:new)
        end
      end
    end

    context 'when user is not an admin' do
      before(:each) do
        sign_in user
        patch :update, params: { id: user.id, user: { email: 'nonsense' } }
      end

      it 'redirects to root page' do
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
