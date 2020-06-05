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
  #     @request.headers['X-User-Email'] = @user.email
  #     @request.headers['X-User-Token'] = @user.authentication_token
  #   end

  #   it 'returns http status created' do
  #     post :create, params: {tweet_id: @tweet, comment: {body: "holi"}}
  #     expect(response).to have_http_status(:created)
  #   end

  #   it 'render json with all tweets' do
  #     post :create, params: {tweet_id: @tweet, comment: {body: "holi"}}
  #     comment = JSON.parse(response.body)
  #     expect(comment["body"]).to eq "holi"
  #   end
  # end

  # describe 'DELETE to destroy' do
  #   before :each do
  #     @user = User.create(username: "test", name: "test", "email" => "test@gmail.com", password: "123456")
  #     @tweet = Tweet.create(owner: @user, body: "tweet body")
  #     @comment = Comment.create(tweet: @tweet, user: @user, body: "comment body")
  #     @admin_user = User.create(username: "admin", name: "admin", "email" => "admin@gmail.com", password: "123456", admin: true)
  #   end

  #   it 'returns http status ok by owner' do
  #     @request.headers['X-User-Email'] = @user.email
  #     @request.headers['X-User-Token'] = @user.authentication_token
  #     delete :destroy, params: {tweet_id: @tweet, id: @comment}
  #     expect(response).to have_http_status(:ok)
  #   end

  #   it 'returns http status ok by admin' do
  #     @request.headers['X-User-Email'] = @admin_user.email
  #     @request.headers['X-User-Token'] = @admin_user.authentication_token
  #     delete :destroy, params: {tweet_id: @tweet, id: @comment}
  #     expect(response).to have_http_status(:ok)
  #   end

  #   it 'render json message by owner' do
  #     @request.headers['X-User-Email'] = @user.email
  #     @request.headers['X-User-Token'] = @user.authentication_token
  #     delete :destroy, params: {tweet_id: @tweet, id: @comment}
  #     comment = JSON.parse(response.body)
  #     expect(comment["messages"]).to eq "Comment deleted - Success"
  #   end

  #   it 'render json message by owner' do
  #     @request.headers['X-User-Email'] = @admin_user.email
  #     @request.headers['X-User-Token'] = @admin_user.authentication_token
  #     delete :destroy, params: {tweet_id: @tweet, id: @comment}
  #     comment = JSON.parse(response.body)
  #     expect(comment["messages"]).to eq "Comment deleted - Success"
  #   end
  # end
end