require 'rails_helper'
require 'byebug'
RSpec.describe "likes a tuit", type: :request do
  describe "likes" do
    let!(:users) do
      create_list(:user,10) do |user,i|
        user.username = Faker::Alphanumeric.unique.alpha(number: 10)
        user.email = Faker::Internet.unique.email
      end
    end
    let!(:user) {users[0]}
    let!(:tuit) {create(:tweet, user: user)}
    describe "list likes" do
      it "get likes to tuit" do
        likes = users.map do |user_like|
          user_like.likes.create(tweet: tuit)
        end
        likes_user_id = likes.map {|like| like.user.id}
        get "/api/tuits/#{tuit.id}/likes"
        get_user_ids = JSON.parse(response.body).map {|user| user["id"]}
        expect(response).to have_http_status(:ok)
        expect(get_user_ids.sort).to eq(likes_user_id.sort)
      end
    end
  end
  describe  "likes authenticate" do
    let!(:user) {create(:user)}
    let!(:tuit) {create(:tweet, user: user)}
    let!(:other_user) {create(:user)}
    let!(:headers_other_user) {headers = { "CONTENT_TYPE": "application/json", "X-User-Token": other_user.authentication_token, "X-User-Email": other_user.email }}
    let!(:headers_user) {headers = { "CONTENT_TYPE": "application/json", "X-User-Token": user.authentication_token, "X-User-Email": user.email }}
    describe  "create like" do
      it "user can like to tuit" do
        post "/api/tuits/#{tuit.id}/likes", headers: headers_other_user
        get_liked_tuit = JSON.parse(response.body)
        expect(response).to have_http_status(:created)
        expect(tuit.id).to eq(get_liked_tuit["id"])
      end
      it "user can like to tuit but he haven't been authenticate" do
        post "/api/tuits/#{tuit.id}/likes"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end