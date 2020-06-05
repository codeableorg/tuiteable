require 'rails_helper'

describe Api::Users::TweetsController do
  describe 'GET to index' do
    before :each do
      @user = User.create(username: "test", name: "test", "email" => "test@gmail.com", password: "123456")
      @tweet = Tweet.create(owner: @user, body: "tweet body")
    end

    it 'returns http status ok' do
      get :index, params: {user_id: @user}
      expect(response).to have_http_status(:ok)
    end

    it 'render json with all tweets' do
      get :index, params: {user_id: @user}
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
      get :show, params: {user_id: @user, id: @tweet}
      expect(response).to have_http_status(:ok)
    end

    it 'render json with tweet info' do
      get :show, params: {user_id: @user, id: @tweet}
      tweet = JSON.parse(response.body)
      expect(tweet["id"]).to eq @tweet.id
      expect(tweet["owner_id"]).to eq @user.id
    end
  end
end