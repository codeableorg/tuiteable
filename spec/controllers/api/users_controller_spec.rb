require 'rails_helper'

describe Api::UsersController do

  describe 'POST to create' do
    it 'returns http status ok' do
      post :create, params: {user: {username: "test", name: "test", "email" => "test@gmail.com", password: "123456"}}
      expect(response).to have_http_status(:created)
    end

    it 'render json with all tweets' do
      post :create, params: {user: {username: "test", name: "test", "email" => "test@gmail.com", password: "123456"}}
      user = JSON.parse(response.body)
      expect(user["username"]).to eq "test"
      expect(user["name"]).to eq "test"
      expect(user["email"]).to eq "test@gmail.com"
    end
  end
end