require 'rails_helper'

describe Api::TweetsController do

    describe 'GET to index' do

        before(:each) do
            @user = User.create(username:"lololo",email:"no@gmail.com",password:"123456")
            @tweet = Tweet.create(body: "Tweet test", user:@user)

        end

        it 'returns http status ok' do
            get :index , params: {id: @user}
            expect(response.status).to eq(200)
        end

        it 'render json with all tweets' do
            get :index , params: {id: @user}
            tweet = JSON.parse(response.body)
            expect(tweet.size).to eq(1) 
        end

    end

    describe 'GET to show' do

        before(:each) do
            @user = User.create(username:"lololo",email:"no@gmail.com",password:"123456")
            @tweet = Tweet.create(body:"Tweet test", user:@user)
        end

        it 'returns http status ok' do
            get :show , params: {user_id: @user, id: @tweet}
            expect(response.status).to eq(200)
        end

        it 'render json with all tweets' do
            get :show , params: {user_id: @user, id: @tweet}
            tweet = JSON.parse(response.body)
            expect(tweet["id"]).to eq(@tweet.id)
        end

    end


end