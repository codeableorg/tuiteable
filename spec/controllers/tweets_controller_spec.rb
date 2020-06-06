require 'rails_helper'

describe Api::TweetsController do
  describe 'GET to index' do
    it 'returns http status ok' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'render json with all tweets' do
      user = User.create(email: 'correo@hotmail.com', tag: 'pepe', password: '123456')
      Tweet.create(user_id: user.id, content: 'Test tweet')
      get :index
      tweets = JSON.parse(response.body)
      expect(tweets.size).to eq 1
    end
  end

  describe 'GET to show' do
    it 'returns http status ok' do
      user = User.create(email: 'correo@hotmail.com', tag: 'pepe', password: '123456')
      tweet = Tweet.create(user_id: user.id, content: 'test')
      get :show, params: { id: tweet }
      expect(response).to have_http_status(:ok)
    end

    it 'render the correct tweet' do
      user = User.create(email: 'correo@hotmail.com', tag: 'pepe', password: '123456')
      tweet = Tweet.create(user_id: user.id, content: 'test')
      get :show, params: { id: tweet }
      expected_tweet = JSON.parse(response.body)
      expect(expected_tweet['id']).to eql(tweet.id)
    end

    it 'returns http status not found' do
      get :show, params: { id: 'xxx' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST to create' do
    it 'returns http status ok' do
      user = User.create(email: 'correo@hotmail.com', tag: 'pepe', password: '123456')
      tweet = { user_id: user.id, content: 'test'}
      post :create, params: { tweet: tweet }
      expect(response).to have_http_status(:ok)
    end

    it 'returns the created tweet' do
      user = User.create(email: 'correo@hotmail.com', tag: 'pepe', password: '123456')
      tweet = { user_id: user.id, content: 'test'}
      post :create, params: { tweet: tweet }
      expected_tweet = JSON.parse(response.body)
      expect(expected_tweet['content']).to eql(tweet[:content])
    end
  end

  describe 'DELETE to destroy' do
    it 'returns http status ok' do
      user = User.create(email: 'correo@hotmail.com', tag: 'pepe', password: '123456')
      tweet = Tweet.create(user_id: user.id, content: 'test')
      delete :destroy, params: { id: tweet}
      expect(response).to have_http_status(:ok)
    end

    it 'delete the requested tweet' do
      user = User.create(email: 'correo@hotmail.com', tag: 'pepe', password: '123456')
      tweet = Tweet.create(user_id: user.id, content: 'test')
      delete :destroy, params: { id: tweet}
      expected_tweet = JSON.parse(response.body)
      expect(expected_tweet['data']['id']).to eql(tweet.id)
      expect(Tweet.count).to eql(0)
    end
  end

  describe 'PATCH to update' do
    it 'returns http status ok' do
      user = User.create(email: 'correo@hotmail.com', tag: 'pepe', password: '123456')
      tweet = Tweet.create(user_id: user.id, content: 'test')
      patch :update, params: { id: tweet, tweet: {content:'new test'}}
      expect(response).to have_http_status(:ok)
    end

    it 'returns the updated tweet' do
      user = User.create(email: 'correo@hotmail.com', tag: 'pepe', password: '123456')
      tweet = Tweet.create(user_id: user.id, content: 'test')
      patch :update, params: { id: tweet, tweet: {content:'new test'}}
      expected_tweet = JSON.parse(response.body)
      expect(expected_tweet['content']).not_to eql(tweet.content)
    end
  end
end