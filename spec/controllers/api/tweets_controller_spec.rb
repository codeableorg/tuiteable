require 'rails_helper'
require 'bcrypt'

describe Api::TweetsController do
  describe 'GET to index' do
    before :each do
      @user = User.create(username: "test", name: "test", "email" => "test@gmail.com", password: "123456")
      @tweet = Tweet.create(owner_id: @user.id, body: "tweet body")
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
      @tweet = Tweet.create(owner_id: @user.id, body: "tweet body")
    end

    it 'returns http status ok' do
      get :show, params: {id: @tweet.id}
      expect(response).to have_http_status(:ok)
    end

    it 'render json with all tweets' do
      get :show, params: {id: @tweet.id}
      tweet = JSON.parse(response.body)
      expect(tweet["body"]).to eq "tweet body"
    end
  end

  describe 'POST to create' do
    before :each do
      @user = User.create(username: "test", name: "test", "email" => "test@gmail.com", password: "123456")
      @request.headers['X-User-Email'] = "test@gmail.com"
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
end