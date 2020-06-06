require 'rails_helper'

describe Api::UsersController do
  before :each do
    @user = User.create(name:'User Example 8', username:'@example8',email:'example8@example.com', bio:'Hi5!', password:123123)
    @tuit = Tuit.create(body:'Tuit example', user_id: @user.id)
  end

  describe 'GET to user_tuits' do
    it 'returns http status ok' do
      get :user_tuits, params: {user_id: @user.id}
      expect(response.status).to eq(200)
    end

    it 'render json with all tuits for one user' do
      get :user_tuits, params: {user_id: @user.id}
      tuits = JSON.parse(response.body)
      expect(tuits.size).to eq 1
    end
  end

  describe 'GET to show_user_tuit' do
    it 'returns http status ok' do
      get :show_user_tuit, params: {user_id: @user.id, id: @tuit.id}
      expect(response).to have_http_status(:ok)
    end

    it 'render the correct tuit of one user' do
      get :show_user_tuit, params: {user_id: @user.id, id: @tuit.id}
      expected_tuit = JSON.parse(response.body)
      expect(expected_tuit["id"]).to eql(@tuit.id)
    end

    it 'returns http status not found' do
      get :show_user_tuit, params: {user_id: @user.id, id: 'xxx'}
      expect(response).to have_http_status(:not_found)
    end
  end
end