require 'rails_helper'

describe Api::TuitsController do
  before :all do
    @user = User.create(name:'User Example', username:'@userexample',email:'user@example.com', bio:'Hi5!', password:123123)
    @tuit = Tuit.create(body:'Tuit example', user: @user)
  end

  describe 'GET to index' do
    it 'returns http status ok' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'render json with all tuits' do
      get :index
      tuits = JSON.parse(response.body)
      expect(tuits.size).to eq 1
    end
  end

  describe 'GET to show' do
    it 'returns http status ok' do
      get :show, params: { id: @tuit.id }
      expect(response).to have_http_status(:ok)
    end

    it 'render the correct game' do
      get :show, params: { id: @tuit.id }
      expected_tuit = JSON.parse(response.body)
      expect(expected_tuit["id"]).to eql(game.id)
    end

    it 'returns http status not found' do
      get :show, params: { id: 'xxx' }
      expect(response).to have_http_status(:not_found)
    end
  end
end