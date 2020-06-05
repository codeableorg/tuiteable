require 'rails_helper'
require 'bcrypt'

describe Api::TweetsController do
  before :each do
    @user = User.create(username: "test", name: "test", "email" => "test@gmail.com", password: "123456")
    @tweet = Tweet.create(owner_id: @user.id, body: "tweet body")
  end

  it 'returns http status ok' do
    get :index
    expect(response).to have_http_status(:ok)
  end

  it 'render json with all tweets' do
    get :index
    tweets = JSON.parse(response.body)
    expect(tweets.size).to eq 1
  end

  it 'returns http status ok' do
    get :show, params: {id: @tweet.id}
    expect(response).to have_http_status(:ok)
  end

  it 'render json with all tweets' do
    get :show, params: {id: @tweet.id}
    tweet = JSON.parse(response.body)
    expect(tweet["body"]).to eq "tweet body"
  end
end