require 'rails_helper'

describe Api::TweetsController do

    describe 'GET to index' do
        it 'returns http status ok' do
            get :index
            expect(response.status).to eq(200)
        end


        it 'render json with all tweets' do
            user = User.create(username:"lololo",email:"no@gmail.com",password:"123456")
            Tweet.create(body: "Tweet test", user:user)
            get :index
            tweet = JSON.parse(response.body)
            expect(tweet.size).to eq 1
        end

    end

    describe 'GET to show' do
        before(:each) do
            user = User.create(username:"lololo",email:"no@gmail.com",password:"123456")
            @tweet = Tweet.create(body: "Tweet test", user:user)
        end

        it 'retuns http status ok' do
            get :show, params:{id: @tweet}
            expect(response.status).to eq(200)
        end

        it 'render the correct tweet' do
            get :show, params:{id: @tweet}
            expected_tweet = JSON.parse(response.body)
            expect(expected_tweet["id"]).to eq(@tweet.id)
        end

        it 'returns http status not found' do
            get :show, params: { id: 'xxx' }
            expect(response).to have_http_status(:not_found)
        end

    end

    describe 'POST to create' do
        it 'returns http status new' do
          user = User.create(username:"lololo",email:"no@gmail.com",password:"123456")
          tweet = {
            tweet:{
              body: 'New tweet',
              user_id: user.id
            }
          }
          post :create ,params: tweet
          expect(response).to have_http_status(:created)
        end
    
        it 'should return error message on ivalid game' do
          tweet = {
            tweet:{
              body: "New tweet",
              user_id: nil
            }
          }
          post :create ,params: tweet
          expect(response).to have_http_status(:unprocessable_entity)
        end
    end

    describe 'DELETE to destroy' do

        it 'returns status ok' do
            user = User.create(username:"lololo",email:"no@gmail.com",password:"123456")
            @tweet = Tweet.create(body: "Tweet test", user:user)
            tweet_size = Tweet.all.size
            delete :destroy, params: {id: @tweet}
            tweet = JSON.parse(response.body)
            expect(tweet_size-tweet.size).to eql 1
        end

    end 

end