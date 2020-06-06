require 'json'
require 'rails_helper'

describe Api::Tuits::LikesController do
  before(:each) do
    @tuiter = User.create!(email: 'tuiter@example.com', password: 'password')
    @tuit = @tuiter.tuits.create!(user: @tuiter, body: 'Some random tuit')
    @liker = User.create!(email: 'liker@example.com', password: 'password')
    @like = @tuit.likes.create!(user: @liker)
    @user = User.create!(email: 'user@example.com', password: 'password')
    # Headers
    request.headers['X-User-Email'] = @user.email
    request.headers['X-User-Token'] = @user.authentication_token
    request.headers['Accept'] = 'application/json'
    # Request
    get :index, params: { tuit_id: @tuit.id }
  end

  context 'GET to show' do
    it 'returns a http status ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns json with all likes' do
      likes = JSON.parse(response.body)
      expect(likes.size).to eq(1)
    end
  end
end

describe Api::Tuits::LikesController do
  before(:each) do
    @tuiter = User.create!(email: 'tuiter@example.com', password: 'password')
    @tuit = @tuiter.tuits.create!(user: @tuiter, body: 'Some random tuit')
    @user = User.create!(email: 'user@example.com', password: 'password')
    # Headers
    request.headers['X-User-Email'] = @user.email
    request.headers['X-User-Token'] = @user.authentication_token
    request.headers['Accept'] = 'application/json'
    # Request
    post :create, params: { tuit_id: @tuit.id }
  end

  context 'POST to create' do
    it 'return a http status created' do
      expect(response).to have_http_status(:created)
    end

    it 'returns the created like' do
      like = JSON.parse(response.body)
      expect(like['id']).to eq(@tuit.likes.last.id)
    end
  end
end


describe Api::Tuits::LikesController do
  before(:each) do
    @tuiter = User.create!(email: 'tuiter@example.com', password: 'password')
    @tuit = @tuiter.tuits.create!(user: @tuiter, body: 'Some random tuit')
    @user = User.create!(email: 'user@example.com', password: 'password')
    @like = @tuit.likes.create!(user: @user)
    # Headers
    request.headers['X-User-Email'] = @user.email
    request.headers['X-User-Token'] = @user.authentication_token
    request.headers['Accept'] = 'application/json'
    # Request
    delete :destroy, params: { tuit_id: @tuit.id, id: @like.id }
  end

  context 'DELETE to destroy' do
    it 'returns a http status no_content' do
      expect(response).to have_http_status(:no_content)
    end

    it 'deletes the requested like' do
      expect { Like.find(@like.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
