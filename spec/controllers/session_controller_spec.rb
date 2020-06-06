require 'rails_helper'

describe Api::SessionController do
  before :all do
    @user = User.create(name:'User Example', username:'@userexample',email:'user@example.com', bio:'Hi5!', password:123123)
  end

  describe "POST for sign in" do
    it "Return status ok" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      post :create, params: { sign_in: {email: @user.email, password: '123123'}}
      expect(response.status).to eq(200)
    end
  end
end