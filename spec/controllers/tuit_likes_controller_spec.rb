require 'rails_helper'

describe Api::TuitLikesController do
  before :each do
    @user = User.create(name:'User Example2', username:'@example2',email:'example2@example.com', bio:'Hi5!', password:123123)
    @tuit = Tuit.create(body:'Tuit example', user_id: @user.id)
    @like = Like.create(user_id:@user.id, tuit_id:@tuit.id)
    @params_second_like = { tuit_id:@tuit.id, user_id: @user.id }
  end

  describe 'GET to tuit_likes' do
    it 'returns http status ok' do
      get :tuit_likes, params: {tuit_id: @tuit.id}
      expect(response.status).to eq(200)
    end

    it 'render json with all likes for a tuit' do
      get :tuit_likes, params: {tuit_id: @tuit.id}
      likes = JSON.parse(response.body)
      expect(likes.size).to eq 1
    end
  end

  describe 'POST to create_like' do
    it 'returns http status unauthorized if there is no correct header' do
      post :create, params: @params_second_like
      expect(response).to have_http_status(:found)
    end

    it 'returns http status created' do
      request.headers['X-User-Token'] = @user.authentication_token
      request.headers['X-User-Email'] = @user.email
      post :create, params: @params_second_like
      expect(response).to have_http_status(:created)
    end

    it 'returns the created like' do
      request.headers['X-User-Token'] = @user.authentication_token
      request.headers['X-User-Email'] = @user.email
      expect{post :create, params: @params_second_like}.to change(Like, :count).by(1)
    end
  end

  describe 'DELETE to destroy' do
    it 'returns http status unauthorized if there is no correct header' do
      expect(delete :destroy, params: { tuit_id:@tuit.id, like_id: @like.id }).to have_http_status(:found)
    end

    it 'returns http status no content' do
      request.headers['X-User-Token'] = @user.authentication_token
      request.headers['X-User-Email'] = @user.email
      expect(delete :destroy, params: { tuit_id:@tuit.id, like_id: @like.id }).to have_http_status(:no_content)
    end

    it 'returns empty body' do
      request.headers['X-User-Token'] = @user.authentication_token
      request.headers['X-User-Email'] = @user.email
      delete :destroy, params: { tuit_id:@tuit.id, like_id: @like.id }
      expect(response.body).to be_empty
    end

    it 'decrement by 1 the total of tuits' do
      request.headers['X-User-Token'] = @user.authentication_token
      request.headers['X-User-Email'] = @user.email
      expect{delete :destroy, params: { tuit_id:@tuit.id, like_id: @like.id }}.to change(Like, :count).by(-1)
    end
  end
end