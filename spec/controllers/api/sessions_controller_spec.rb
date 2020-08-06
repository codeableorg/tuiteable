require 'rails_helper'

describe Api::SessionsController do
  it "POST to login to account " do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user_data = {
      "email": "admin@gmail.com",
      "password": 123456,
    }
    acc = User.create(**user_data, username: "admin")
    post :create, params: { login: user_data }
    user_response = JSON.parse(response.body)
    expect(acc.email).to eq(user_response["data"]["user"]["email"])
  end
end
