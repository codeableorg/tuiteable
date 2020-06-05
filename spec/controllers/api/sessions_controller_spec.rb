require 'rails_helper'

describe Api::SessionsController do
  describe 'POST to create' do
    before :each do
      User.create(username: "test", name: "test", "email" => "test@gmail.com", password: "123456")
    end

    it 'returns http status created' do
      post :create, params: {session: {email: "test@gmail.com", password: "123456"}}
      expect(response).to have_http_status(:created)
    end

    it 'render json with email for valid params' do
      post :create, params: {session: {email: "test@gmail.com", password: "123456"}}
      session = JSON.parse(response.body)
      expect(session["email"]).to eq "test@gmail.com"
    end

    it 'returns http status unauthorized for invalid params' do
      post :create, params: {session: {email: "test@gmail.com", password: "1123"}}
      expect(response).to have_http_status(:unauthorized)
    end

    it 'render message error for invalid params' do
      post :create, params: {session: {email: "test@gmail.com", password: "1123"}}
      session = JSON.parse(response.body)
      expect(session["messages"]).to eq "Signed In Failed - Unauthorized"
    end

  end

  describe 'delete to destroy' do
    before :each do
      User.create(username: "test", name: "test", "email" => "test@gmail.com", password: "123456")
    end

    it 'returns http status ok for log_out' do
      post :create, params: {session: {email: "test@gmail.com", password: "123456"}}

      token = JSON.parse(response.body)["authentication_token"]
      @request.headers['X-User-Email'] = "test@gmail.com"
      @request.headers['X-User-Token'] = token

      delete :destroy
      delete_resp = JSON.parse(response.body)
      expect(delete_resp["messages"]).to eq "Log out - Success"
    end
  end

end