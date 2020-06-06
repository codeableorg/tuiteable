require 'rails_helper'

describe Api::LikesController do

    describe 'GET to index' do

        before(:each) do
            @user = User.create(username:"lololo",email:"no@gmail.com",password:"123456")
            @tweet = Tweet.create(body: "Tweet test", user:@user)
            @like = Like.create(user:@user, tweet:@tweet)
        end

        it 'returns http status ok' do
            get  :index , params: {id: @tweet}
            expect(response.status).to eq(200)
        end

        it 'render json with all tweets' do
            get :index , params: {id: @tweet}
            like = JSON.parse(response.body)
            expect(like.size).to eq(1) 
        end

    end

    describe 'POST to create' do
        it 'returns http status new' do
          user = User.create(username:"lololo",email:"no@gmail.com",password:"123456")
          tweet = Tweet.create(body: "Tweet test", user:@user)
          like = {
            like:{
              user_id: user.id,
              tweet_id: tweet.id
            }
          }
          post :create ,params: like
          expect(response).to have_http_status(:created)
        end
    
        it 'should return error message on ivalid game' do
            like = {
                like:{
                  user_id: nil,
                  tweet_id: nil
                }
              }
          post :create ,params: like
          expect(response).to have_http_status(:unprocessable_entity)
        end
    end

    describe 'DELETE to destroy' do

        it 'returns status ok' do
            user = User.create(username:"lololo",email:"no@gmail.com",password:"123456")
            tweet = Tweet.create(body: "Tweet test", user:user)
            @like = Like.create(body:"Comment test", user:@user, tweet:@tweet)
            like_size = Like.all.size
            delete :destroy, params: {id: @like}
            like = JSON.parse(response.body)
            expect(like_size-like.size).to eql 1
        end

    end 



end