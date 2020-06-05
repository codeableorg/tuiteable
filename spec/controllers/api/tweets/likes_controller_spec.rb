require 'rails_helper'

describe Api::Tweets::LikesController do
  describe 'GET to index' do
    before :each do
      @user = User.create(username: "test", name: "test", "email" => "test@gmail.com", password: "123456")
      @tweet = Tweet.create(owner: @user, body: "tweet body")
      @like = Like.create(tweet: @tweet, user: @user)
    end

    it 'returns http status ok' do
      get :index, params: {tweet_id: @tweet}
      expect(response).to have_http_status(:ok)
    end

    it 'render json with all likes' do
      get :index, params: {tweet_id: @tweet}
      likes = JSON.parse(response.body)
      expect(likes.size).to eq 1
    end

  end

  # describe 'POST to create' do
  #   before :each do
  #     @user = User.create(username: "test", name: "test", "email" => "test@gmail.com", password: "123456")
  #     @tweet = Tweet.create(owner: @user, body: "tweet body")
  #   end

  #   it 'returns http status created' do
  #     post :create, params: {tweet_id: @tweet}
  #     expect(response).to have_http_status(:created)
  #   end

  #   it 'render json like info' do
  #     post :create, params: {tweet_id: @tweet}
  #     like = JSON.parse(response.body)
  #     expect(like["tweet_id"]).to eq @tweet.id
  #     expect(like["user_id"]).to eq @user.id
  #   end

  #   it 'returns http status :not_acceptable with preview liked tweet' do
  #     Like.create(user: @user, tweet: @tweet)
  #     post :create, params: {tweet_id: @tweet}
  #     expect(response).to have_http_status(:not_acceptable)
  #   end

  #   it 'render json error info when like a with preview liked tweet' do
  #     post :create, params: {tweet_id: @tweet}
  #     like = JSON.parse(response.body)
  #     expect(like["error"]).to eq "the tweet with id #{@tweet.id} was already liked by the current user"
  #   end
  # end

  # describe 'DELETE to destroy' do
  #   before :each do
  #     @user = User.create(username: "test", name: "test", "email" => "test@gmail.com", password: "123456")
  #     @tweet = Tweet.create(owner: @user, body: "tweet body")
  #   end

  #   it 'returns http status ok by owner' do
  #     @like = Like.create(user: @user, tweet: @tweet)
  #     @request.headers['X-User-Email'] = @user.email
  #     @request.headers['X-User-Token'] = @user.authentication_token
  #     delete :destroy, params: {tweet_id: @tweet}
  #     expect(response).to have_http_status(:ok)
  #   end

  #   it 'render json message by owner' do
  #     @like = Like.create(user: @user, tweet: @tweet)
  #     @request.headers['X-User-Email'] = @user.email
  #     @request.headers['X-User-Token'] = @user.authentication_token
  #     delete :destroy, params: {tweet_id: @tweet}
  #     like = JSON.parse(response.body)
  #     expect(like["messages"]).to eq "Like deleted - Success"
  #   end

  #   it 'returns http status :not_acceptable with no preview liked tweet' do
  #     delete :destroy, params: {tweet_id: @tweet}
  #     expect(response).to have_http_status(:not_acceptable)
  #   end

  # end
end