require 'rails_helper'

describe Api::LikesController do
  before do
    user_data = {
      username: 'user',
      email: "user@email.com",
      password: 123456,
    }
    adm_data = {
      username: 'admin',
      email: "admin@email.com",
      password: 123456,
    }
    @admin = User.create!(**adm_data, is_admin: true)
    @user = User.create!(user_data)
    @tuit = Tuit.create(body: 'New tuit', owner: @user)
    @request.headers['X-User-Email'] = @user.email
    @request.headers['X-User-Token'] = @user.authentication_token
  end

  it "GET to GET ALL VOTES" do
    @tuit.votes.create!(user: @user)
    @tuit.votes.create!(user: @admin)
    get :index, params: { tuit_id: @tuit }
    votes_response = JSON.parse(response.body)
    expect(votes_response.size).to eq(2)
  end

  it "POST to UPVOTE" do
    post :create, params: { tuit_id: @tuit }
    vote_response = JSON.parse(response.body)
    expect(vote_response["data"]["tuit_id"]).to eq(@tuit.id)
  end

  it "DELETE to DOWNVOTE" do
    @tuit.votes.create!(user: @user)
    delete :destroy, params: { tuit_id: @tuit }
    expect(response).to have_http_status(:no_content)
  end
end
