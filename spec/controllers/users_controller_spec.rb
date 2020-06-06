require 'rails_helper'

describe Api::UsersController do
  describe 'GET to index' do
    it 'returns http status ok' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'render json with all users' do
      User.create(email: 'pepito@gmail.com', tag: 'pepe', password: '123456')
      get :index
      users = JSON.parse(response.body)
      expect(users.size).to eq 1
    end
  end

  describe 'GET to show' do
    it 'returns http status ok' do
      user = User.create(email: 'correo@hotmail.com', tag: 'pepe', password: '123456')
      get :show, params: { id: user }
      expect(response).to have_http_status(:ok)
    end

    it 'render the correct user' do
      user = User.create(email: 'correo@hotmail.com', tag: 'pepe', password: '123456')
      get :show, params: { id: user }
      expected_user = JSON.parse(response.body)
      expect(expected_user['id']).to eql(user.id)
    end

    it 'returns http status not found' do
      get :show, params: { id: 'xxx' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST to create' do
    it 'returns http status ok' do
      user = { email: 'c@gmail.com', tag: 'pep', password: '123456' }
      post :create, params: { user: user }
      expect(response).to have_http_status(:ok)
    end

    it 'returns the created user' do
      user = { email: 'c@gmail.com', tag: 'pep', password: '123456' }
      post :create, params: { user: user }
      expected_user = JSON.parse(response.body)
      expect(expected_user['email']).to eql(user[:email])
    end
  end

  describe 'DELETE to destroy' do
    it 'returns http status ok' do
      user = User.create(email: 'correo@hotmail.com', tag: 'pepe', password: '123456')
      delete :destroy, params: { id: user }
      expect(response).to have_http_status(:ok)
    end

    it 'delete the requested user' do
      user = User.create(email: 'correo@hotmail.com', tag: 'pepe', password: '123456')
      delete :destroy, params: { id: user }
      expected_user = JSON.parse(response.body)
      expect(expected_user['data']['id']).to eql(user.id)
      expect(User.count).to eql(0)
    end
  end
  describe 'PATCH to update' do
    it 'returns http status ok' do
      user = User.create(email: 'correo@hotmail.com', tag: 'pepe', password: '123456')
      patch :update, params: { id: user.id, user: { email: 'corre@hotmail.com' } }
      expect(response).to have_http_status(:ok)
    end

    it 'returns the updated user' do
      user = User.create(email: 'correo@hotmail.com', tag: 'pepe', password: '123456')
      patch :update, params: { id: user.id, user: { email: 'corre@hotmail.com' } }
      expected_user = JSON.parse(response.body)
      expect(expected_user['email']).not_to eql(user.email)
    end
  end
end