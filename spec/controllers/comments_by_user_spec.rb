require 'rails_helper'

describe Api::CommentsController do

    describe 'GET to index' do

        before(:each) do
            @user = User.create(username:"lololo",email:"no@gmail.com",password:"123456")
            @tweet = Tweet.create(body: "Tweet test", user:@user)
            @comment = Comment.create(body:"Comment test", user:@user, tweet:@tweet)
        end

        it 'returns http status ok' do
            get  :index , params: {id: @tweet}
            expect(response.status).to eq(200)
        end

        it 'render json with all tweets' do
            get :index , params: {id: @tweet}
            coment = JSON.parse(response.body)
            expect(coment.size).to eq(1) 
        end

    end

    describe 'GET to show' do

        before(:each) do
            @user = User.create(username:"lololo",email:"no@gmail.com",password:"123456")
            @tweet = Tweet.create(body: "Tweet test", user:@user)
            @comment = Comment.create(body:"Comment test", user:@user, tweet:@tweet)
        end

        it 'returns http status ok' do
            get :show , params: {tweet_id: @tweet, id: @comment}
            expect(response.status).to eq(200)
        end

        it 'render json with all tweets' do
            get :show , params: {tweet_id: @tweet, id: @comment}
            coment = JSON.parse(response.body)
            expect(coment["id"]).to eq(@comment.id)
        end

    end

    describe 'POST to create' do
        it 'returns http status new' do
          user = User.create(username:"lololo",email:"no@gmail.com",password:"123456")
          tweet = Tweet.create(body: "Tweet test", user:@user)
          comment = {
            coment:{
              body: 'New comment',
              user_id: user.id,
              tweet_id: tweet.id
            }
          }
          post :create ,params: comment
          expect(response).to have_http_status(:created)
        end
    
        it 'should return error message on ivalid game' do
            comment = {
                coment:{
                  body: 'New comment',
                  user_id: nil,
                  tweet_id: nil
                }
              }
          post :create ,params: comment
          expect(response).to have_http_status(:unprocessable_entity)
        end
    end

    describe 'DELETE to destroy' do

        it 'returns status ok' do
            user = User.create(username:"lololo",email:"no@gmail.com",password:"123456")
            tweet = Tweet.create(body: "Tweet test", user:user)
            @comment = Comment.create(body:"Comment test", user:@user, tweet:@tweet)
            comment_size = Comment.all.size
            delete :destroy, params: {id: @comment}
            coment = JSON.parse(response.body)
            expect(comment_size-coment.size).to eql 1
        end

    end 



end