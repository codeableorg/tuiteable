require 'rails_helper'
RSpec.describe "Sessions users", type: :request do
  describe "Register" do
    it "Registrar usuario" do
      headers = { "CONTENT_TYPE" => "application/json" }
      params = {
          user: {
              email:"abc@example.com",
              password:"password",
              password_confirmation:"password",
              username: "jorgitoluis"
          }
      }
      post "/api/users", params: params.to_json, headers: headers
      user = JSON.parse(response.body)
      expect(response).to have_http_status(:created)
      expect(user["data"]["user"]["authentication_token"]).not_to be_nil
      expect(user["data"]["user"]["id"]).not_to be_nil
    end
    it "Registrar usuario incorrecto" do
      headers = { "CONTENT_TYPE" => "application/json" }
      params = {
          user: {
              email:"abc@example.com",
              password:"passworsdd",
              password_confirmation:"password",
              username: "jorgitoluis"
          }
      }
      post "/api/users", params: params.to_json, headers: headers
      user = JSON.parse(response.body)
      expect(response).to have_http_status(:unprocessable_entity)
    end

  end
  describe "Sign in" do
    before do
      headers = { "CONTENT_TYPE" => "application/json" }
      params = {
          user: {
              email:"abc@example.com",
              password:"password",
              password_confirmation:"password",
              username: "jorgeluis"
          }
      }
      post "/api/users", params: params.to_json, headers: headers
    end
    it "Prueba Sing in" do
      params = {
          user: {
              email:"abc@example.com",
              password:"password",
              username: "jorgeluis"
          }
      }
      post "/api/sessions/sign_in", params: params.to_json, headers: headers
      user = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(user["data"]["user"]["id"]).not_to be_nil
      expect(user["data"]["user"]["authentication_token"]).not_to be_nil
    end
    it "prueba con datos invalidos" do
      params = {
          user: {
              email:"abc@example.com",
              password:"passasdfword",
              username: "jorgeluis"
          }
      }
      post "/api/sessions/sign_in", params: params.to_json, headers: headers
      user = JSON.parse(response.body)
      expect(response).to have_http_status(:unauthorized)
      expect(user["data"]).to be_empty
      expect(user["is_success"]).to be_falsey
    end
  end
  describe  "log out" do
    let!(:user) { create(:user) }
    it "logout" do
      email = user.email
      token = user.authentication_token
      headers = {
          "X-User-Email" => email,
          "X-User-Token" => token
      }
      delete "/api/sessions/log_out", headers: headers
      respond = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
    end
  end
end

