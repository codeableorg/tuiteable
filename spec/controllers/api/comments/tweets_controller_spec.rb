require 'rails_helper'

describe Api::Tweets::CommentsController do
  describe 'GET to index' do
    before :each do
      @user = User.create(username: "test", name: "test", "email" => "test@gmail.com", password: "123456")
      @tweet = Tweet.create(owner: @user, body: "tweet body")
      @comment = Comment.create(tweet: @tweet, user: @user, body: "comment body")
    end

    it 'returns http status ok' do
      get :index, params: {tweet_id: @tweet}
      expect(response).to have_http_status(:ok)
    end

    it 'render json with all tweets' do
      get :index, params: {tweet_id: @tweet}
      comments = JSON.parse(response.body)
      expect(comments.size).to eq 1
    end

  end

  describe 'GET to show' do
    before :each do
      @user = User.create(username: "test", name: "test", "email" => "test@gmail.com", password: "123456")
      @tweet = Tweet.create(owner: @user, body: "tweet body")
      @comment = Comment.create(tweet: @tweet, user: @user, body: "comment body")
    end

    it 'returns http status ok' do
      get :show, params: {tweet_id: @tweet, id: @comment}
      expect(response).to have_http_status(:ok)
    end

    it 'render json with comment info' do
      get :show, params: {tweet_id: @tweet, id: @comment}
      comment = JSON.parse(response.body)
      expect(comment["body"]).to eq "comment body"
    end
  end

  describe 'POST to create' do
    before :each do
      @user = User.create(username: "test", name: "test", "email" => "test@gmail.com", password: "123456")
      @tweet = Tweet.create(owner: @user, body: "tweet body")
      @request.headers['X-User-Email'] = @user.email
      @request.headers['X-User-Token'] = @user.authentication_token
    end

    it 'returns http status created' do
      post :create, params: {tweet_id: @tweet, comment: {body: "holi"}}
      expect(response).to have_http_status(:created)
    end

    it 'render json with all tweets' do
      post :create, params: {tweet_id: @tweet, comment: {body: "holi"}}
      comment = JSON.parse(response.body)
      expect(comment["body"]).to eq "holi"
    end
  end

  # describe 'PUT to update' do
  #   before :each do
  #     @user = User.create(username: "test", name: "test", "email" => "test@gmail.com", password: "123456")
  #     @admin_user = User.create(username: "admin", name: "admin", "email" => "admin@gmail.com", password: "123456", admin: true)
  #     @tweet = Tweet.create(owner_id: @user.id, body: "tweet body")
  #   end

  #   it 'returns http status created by owner' do
  #     @request.headers['X-User-Email'] = @user.email
  #     @request.headers['X-User-Token'] = @user.authentication_token
  #     put :update, params: {id: @tweet.id, tweet: {body: "woli"}}
  #     expect(response).to have_http_status(:ok)
  #   end

  #   it 'returns http status created by admin' do
  #     @request.headers['X-User-Email'] = @admin_user.email
  #     @request.headers['X-User-Token'] = @admin_user.authentication_token
  #     put :update, params: {id: @tweet.id, tweet: {body: "woli"}}
  #     expect(response).to have_http_status(:ok)
  #   end

  #   it 'render json with updated tweet by owner' do
  #     @request.headers['X-User-Email'] = @user.email
  #     @request.headers['X-User-Token'] = @user.authentication_token
  #     put :update, params: {id: @tweet.id, tweet: {body: "woli"}}
  #     tweet = JSON.parse(response.body)
  #     expect(tweet["body"]).to eq "woli"
  #   end

  #   it 'render json with updated tweet by admin' do
  #     @request.headers['X-User-Email'] = @admin_user.email
  #     @request.headers['X-User-Token'] = @admin_user.authentication_token
  #     put :update, params: {id: @tweet.id, tweet: {body: "woli"}}
  #     tweet = JSON.parse(response.body)
  #     expect(tweet["body"]).to eq "woli"
  #   end
  # end

  # describe 'DELETE to destroy' do
  #   before :each do
  #     @user = User.create(username: "test", name: "test", "email" => "test@gmail.com", password: "123456")
  #     @admin_user = User.create(username: "admin", name: "admin", "email" => "admin@gmail.com", password: "123456", admin: true)
  #     @tweet = Tweet.create(owner_id: @user.id, body: "tweet body")
  #   end

  #   it 'returns http status ok by owner' do
  #     @request.headers['X-User-Email'] = @user.email
  #     @request.headers['X-User-Token'] = @user.authentication_token
  #     delete :destroy, params: {id: @tweet.id}
  #     expect(response).to have_http_status(:ok)
  #   end

  #   it 'returns http status ok by admin' do
  #     @request.headers['X-User-Email'] = @admin_user.email
  #     @request.headers['X-User-Token'] = @admin_user.authentication_token
  #     delete :destroy, params: {id: @tweet.id}
  #     expect(response).to have_http_status(:ok)
  #   end

  #   it 'render json message by owner' do
  #     @request.headers['X-User-Email'] = @user.email
  #     @request.headers['X-User-Token'] = @user.authentication_token
  #     delete :destroy, params: {id: @tweet.id}
  #     tweet = JSON.parse(response.body)
  #     expect(tweet["messages"]).to eq "Tweet deleted - Success"
  #   end

  #   it 'render json message by owner' do
  #     @request.headers['X-User-Email'] = @admin_user.email
  #     @request.headers['X-User-Token'] = @admin_user.authentication_token
  #     delete :destroy, params: {id: @tweet.id}
  #     tweet = JSON.parse(response.body)
  #     expect(tweet["messages"]).to eq "Tweet deleted - Success"
  #   end
  # end
end