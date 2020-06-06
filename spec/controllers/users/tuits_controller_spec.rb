require 'json'
require 'rails_helper'

describe Api::Users::TuitsController do
  before(:each) do
    @user = User.create!(email: 'user@example.com', password: 'password')
    @tuiter = User.create!(email: 'tuiter@example.com', password: 'password')
    @tuit = Tuit.create!(user: @tuiter, body: 'Some random tuit')
    @tuits_count_before = @tuiter.tuits.size
  end

  context 'GET to index' do
    it 'returns a http status ok' do
      get :index, params: { user_id: @tuiter.id }
      expect(response).to have_http_status(:ok)
    end

    it 'renders json with all tuits' do
      get :index, params: { user_id: @tuiter.id }
      tuits = JSON.parse(response.body)
      expect(tuits.size).to eq(1)
    end
  end

  context 'GET to show' do
    it 'returns http status ok' do
      get :show, params: { user_id: @tuiter.id, id: @tuit.id }
      expect(response).to have_http_status(:ok)
    end

    it 'renders the correct game' do
      get :show, params: { user_id: @tuiter.id, id: @tuit.id }
      tuit = JSON.parse(response.body)
      expect(tuit['id']).to eq(@tuit.id)
    end

    it 'returns http status not found' do
      get :show, params: { user_id: 'xxx', id: 'xx' }
      expect(response).to have_http_status(:not_found)
    end
  end
end
