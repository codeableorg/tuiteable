require 'rails_helper'

describe Api::LikesController do
    describe 'GET to index' do
        it 'returns http status ok' do
            get :index
            expect(response).to have_http_status(:ok)
        end

        it 'render json with all likes' do
            user = User.create(email: 'correo@hotmail.com', tag: 'pepe', password: '123456')
            tweet = Tweet.create(user_id: user.id, content: "test")
            like = Like.create(user_id: user.id, tweet_id: tweet.id)
            get :index
            likes = JSON.parse(response.body)
            expect(likes.size).to eql(1)
        end
    end
    
    describe 'POST to create' do
        it 'returns http status ok' do
            user = User.create(email: 'correo@hotmail.com', tag: 'pepe', password: '123456')
            tweet = Tweet.create(user_id: user.id, content: "test")
            like = { user_id: user.id, tweet_id: tweet.id}
            post :create, params: { like: like}
            expect(response).to have_http_status(:ok)
        end

        it 'returns the created like' do
            user = User.create(email: 'correo@hotmail.com', tag: 'pepe', password: '123456')
            tweet = Tweet.create(user_id: user.id, content: "test")
            like = { user_id: user.id, tweet_id: tweet.id}
            post :create, params: { like: like}
            expect(response).to have_http_status(:ok)
            expected_like = JSON.parse(response.body)
            expect(expected_like["user_id"]).to eql(like[:user_id])
        end
    end

    describe 'DELETE to destroy' do
        it 'returns http status ok' do
            user = User.create(email: 'correo@hotmail.com', tag: 'pepe', password: '123456')
            tweet = Tweet.create(user_id: user.id, content: "test")
            like = Like.create(user_id: user.id, tweet_id: tweet.id)
            delete :destroy, params: { id: like}
            expect(response).to have_http_status(:ok)
        end

        it 'delete the requested like' do
            user = User.create(email: 'correo@hotmail.com', tag: 'pepe', password: '123456')
            tweet = Tweet.create(user_id: user.id, content: "test")
            like = Like.create(user_id: user.id, tweet_id: tweet.id)
            delete :destroy, params: { id: like}
            expected_like = JSON.parse(response.body)
            expect(expected_like["data"]["id"]).to eql(like.id)
            expect(Like.count).to eql(0)
        end
    end
end