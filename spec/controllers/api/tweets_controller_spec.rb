require 'rails_helper'

describe Api::TweetsController do
  describe 'GET to index' do
    before :each do
      @user = User.create(username: "test", name: "test", "email" => "test@gmail.com", password: "123456")
      @tweet = Tweet.create(owner: @user, body: "tweet body")
    end

    it 'returns http status ok' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'render json with all tweets' do
      get :index
      tweets = JSON.parse(response.body)
      expect(tweets.size).to eq 1
    end

  end

  describe 'GET to show' do
    before :each do
      @user = User.create(username: "test", name: "test", "email" => "test@gmail.com", password: "123456")
      @tweet = Tweet.create(owner: @user, body: "tweet body")
    end

    it 'returns http status ok' do
      get :show, params: {id: @tweet}
      expect(response).to have_http_status(:ok)
    end

    it 'render json with all tweets' do
      get :show, params: {id: @tweet}
      tweet = JSON.parse(response.body)
      expect(tweet["body"]).to eq "tweet body"
    end
  end

  describe 'POST to create' do
    before :each do
      @user = User.create(username: "test", name: "test", "email" => "test@gmail.com", password: "123456")
      @request.headers['X-User-Email'] = @user.email
      @request.headers['X-User-Token'] = @user.authentication_token
    end

    it 'returns http status created' do
      post :create, params: {tweet: {body: "holi"}}
      expect(response).to have_http_status(:created)
    end

    it 'render json with all tweets' do
      post :create, params: {tweet: {body: "holi"}}
      tweet = JSON.parse(response.body)
      expect(tweet["body"]).to eq "holi"
    end
  end

  describe 'PUT to update' do
    before :each do
      @user = User.create(username: "test", name: "test", "email" => "test@gmail.com", password: "123456")
      @admin_user = User.create(username: "admin", name: "admin", "email" => "admin@gmail.com", password: "123456", admin: true)
      @tweet = Tweet.create(owner: @user, body: "tweet body")
    end

    it 'returns http status created by owner' do
      @request.headers['X-User-Email'] = @user.email
      @request.headers['X-User-Token'] = @user.authentication_token
      put :update, params: {id: @tweet, tweet: {body: "woli"}}
      expect(response).to have_http_status(:ok)
    end

    it 'returns http status created by admin' do
      @request.headers['X-User-Email'] = @admin_user.email
      @request.headers['X-User-Token'] = @admin_user.authentication_token
      put :update, params: {id: @tweet, tweet: {body: "woli"}}
      expect(response).to have_http_status(:ok)
    end

    it 'render json with updated tweet by owner' do
      @request.headers['X-User-Email'] = @user.email
      @request.headers['X-User-Token'] = @user.authentication_token
      put :update, params: {id: @tweet, tweet: {body: "woli"}}
      tweet = JSON.parse(response.body)
      expect(tweet["body"]).to eq "woli"
    end

    it 'render json with updated tweet by admin' do
      @request.headers['X-User-Email'] = @admin_user.email
      @request.headers['X-User-Token'] = @admin_user.authentication_token
      put :update, params: {id: @tweet, tweet: {body: "woli"}}
      tweet = JSON.parse(response.body)
      expect(tweet["body"]).to eq "woli"
    end
  end

  describe 'DELETE to destroy' do
    before :each do
      @user = User.create(username: "test", name: "test", "email" => "test@gmail.com", password: "123456")
      @admin_user = User.create(username: "admin", name: "admin", "email" => "admin@gmail.com", password: "123456", admin: true)
      @tweet = Tweet.create(owner: @user, body: "tweet body")
    end

    it 'returns http status ok by owner' do
      @request.headers['X-User-Email'] = @user.email
      @request.headers['X-User-Token'] = @user.authentication_token
      delete :destroy, params: {id: @tweet}
      expect(response).to have_http_status(:ok)
    end

    it 'returns http status ok by admin' do
      @request.headers['X-User-Email'] = @admin_user.email
      @request.headers['X-User-Token'] = @admin_user.authentication_token
      delete :destroy, params: {id: @tweet}
      expect(response).to have_http_status(:ok)
    end

    it 'render json message by owner' do
      @request.headers['X-User-Email'] = @user.email
      @request.headers['X-User-Token'] = @user.authentication_token
      delete :destroy, params: {id: @tweet}
      tweet = JSON.parse(response.body)
      expect(tweet["messages"]).to eq "Tweet deleted - Success"
    end

    it 'render json message by owner' do
      @request.headers['X-User-Email'] = @admin_user.email
      @request.headers['X-User-Token'] = @admin_user.authentication_token
      delete :destroy, params: {id: @tweet}
      tweet = JSON.parse(response.body)
      expect(tweet["messages"]).to eq "Tweet deleted - Success"
    end
  end
end