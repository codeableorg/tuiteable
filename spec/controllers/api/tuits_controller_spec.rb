require 'rails_helper'

describe Api::TuitsController do
  before do
    user_data = {
      username: 'user',
      email: "user@email.com",
      password: 123456,
    }
    adm_data = {
      username: 'admin',
      email: "admin@email.com",
      password: 123456,
    }
    @admin = User.create!(**adm_data, is_admin: true)
    @user = User.create!(user_data)
  end

  describe 'GET to index' do
    it 'returns http status ok' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'render json with all tuits' do
      2.times do
        Tuit.create!(owner: @user, body: 'tuits')
      end
      get :index
      tuits = JSON.parse(response.body)
      expect(tuits.size).to eq 2
    end
  end

  describe 'GET to show tuit' do
    it 'returns http status ok' do
      tuit = Tuit.create(body: 'New tuit', owner: @user)
      get :show, params: { id: tuit }
      expect(response).to have_http_status(:ok)
    end

    it 'render the correct tuit' do
      tuit = Tuit.create(body: 'New tuit', owner: @user)
      get :show, params: { id: tuit }
      expected_tuit = JSON.parse(response.body)
      expect(expected_tuit["id"]).to eql(tuit.id)
    end
  end

  describe 'POST to create' do
    before :each do
      @request.headers['X-User-Email'] = @user.email
      @request.headers['X-User-Token'] = @user.authentication_token
    end

    it 'returns http status ok' do
      tuit = { body: 'New tuit' }
      post :create, params: { tuit: tuit }
      expect(response).to have_http_status(:ok)
    end

    it 'returns the created tuit' do
      tuit = { body: 'New tuit' }
      post :create, params: { tuit: tuit }
      expected_tuit = JSON.parse(response.body)
      expect(expected_tuit["data"]["body"]).to eql(tuit[:body])
    end
  end

  describe 'PATCH to update' do
    before :each do
      @request.headers['X-User-Email'] = @user.email
      @request.headers['X-User-Token'] = @user.authentication_token
    end

    it 'returns http status ok' do
      _tuit = Tuit.create(body: 'New tuit', owner: @user)
      tuit = { body: 'New tuit2' }
      patch :update, params: { id: _tuit, tuit: tuit }
      expect(response).to have_http_status(:ok)
    end

    it 'render the updated tuit' do
      _tuit = Tuit.create(body: 'New tuit', owner: @user)
      tuit = { body: 'New tuit2' }
      patch :update, params: { id: _tuit, tuit: tuit }
      expected_tuit = JSON.parse(response.body)
      expect(expected_tuit["data"]["id"]).to eql(_tuit.id)
    end
  end

  describe 'DELETE to delete' do
    before :each do
      @request.headers['X-User-Email'] = @user.email
      @request.headers['X-User-Token'] = @user.authentication_token
    end

    it 'returns http status no content' do
      tuit = Tuit.create(body: 'New tuit', owner: @user)
      delete :destroy, params: { id: tuit }
      expect(response).to have_http_status(:no_content)
    end

    it 'render the correct tuit' do
      Tuit.create(body: 'New tuit', owner: @user)
      tuit = Tuit.create(body: 'Brand New tuit', owner: @user)
      delete :destroy, params: { id: tuit }
      expect(response.body).to eql("")
      expect(Tuit.count).to eql(1)
      expect(Tuit.exists?(tuit.id)).to eql(false)
    end
  end
end
