require 'rails_helper'

describe Api::UsersController do
  it "POST to create account" do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user_data = {
      "username": "admin",
      "email": "admin@gmail.com",
      "password": 123456,
    }
    post :create, params: { user: user_data }
    user_response = JSON.parse(response.body)
    expect(User.last.username).to eq(user_response["data"]["user"]["username"])
  end
end
