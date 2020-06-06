require 'json'
require 'rails_helper'

describe Api::TuitsController do
  context 'GET to index' do
    before(:each) do
      @user = User.create!(email: 'user@example.com', password: 'password')
      @tuit = Tuit.create!(user: @user, body: 'Some random tuit')
    end

    it 'returns a http status ok' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'renders json with all tuits' do
      get :index
      tuits = JSON.parse(response.body)
      expect(tuits.size).to eq(1)
    end
  end

  context 'GET to show' do
    before(:each) do
      @user = User.create!(email: 'user@example.com', password: 'password')
      @tuit = Tuit.create!(user: @user, body: 'Some random tuit')
      @tuits_count_before = @user.tuits.size
      request.headers['X-User-Email'] = @user.email
      request.headers['X-User-Token'] = @user.authentication_token
      request.headers['Accept'] = 'application/json'
    end

    it 'returns a http status ok' do
      get :show, params: { id: @tuit.id }
      expect(response).to have_http_status(:ok)
    end

    it 'renders the correct tuit' do
      get :show, params: { id: @tuit.id }
      tuit = JSON.parse(response.body)
      expect(tuit['id']).to eq(@tuit.id)
    end

    it 'returns a http status not_found' do
      get :show, params: { id: 'xxx' }
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'POST to create' do
    before(:each) do
      @user = User.create!(email: 'user@example.com', password: 'password')
      request.headers['X-User-Email'] = @user.email
      request.headers['X-User-Token'] = @user.authentication_token
      request.headers['Accept'] = 'application/json'
    end

    it 'return a http status created' do
      post :create, params: { tuit: { body: 'Some random tuit' } }
      expect(response).to have_http_status(:created)
    end

    it 'renders the created tuit' do
      post :create, params: { tuit: { body: 'Some random tuit' } }
      tuit = JSON.parse(response.body)
      expect(tuit['id']).to eq(@user.tuits.last.id)
    end

    it 'returns a http status unauthorized' do
      request.headers['X-User-Token'] = 'xxxxxxxxxxxxxxx'
      post :create, params: { tuit: { body: 'Some random tuit' } }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'DELETE to destroy' do
    before(:each) do
      @user = User.create!(email: 'user@example.com', password: 'password')
      @tuit = Tuit.create!(user: @user, body: 'Some random tuit')
      @tuits_count_before = @user.tuits.size
      request.headers['X-User-Email'] = @user.email
      request.headers['X-User-Token'] = @user.authentication_token
      request.headers['Accept'] = 'application/json'
    end

    it 'returns a http status no_content' do
      delete :destroy, params: { id: @tuit.id }
      expect(response).to have_http_status(:no_content)
    end

    it 'returns an empty response' do
      delete :destroy, params: { id: @tuit.id }
      expect(response.body).to be_empty
    end

    it 'decrement by 1 the total of game' do
      delete :destroy, params: { id: @tuit.id }
      tuits_count_after = @user.tuits.size
      expect(tuits_count_after).to be(@tuits_count_before - 1)
    end

    it 'deletes the requested game' do
      delete :destroy, params: { id: @tuit.id }
      expect { Tuit.find(@tuit.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
