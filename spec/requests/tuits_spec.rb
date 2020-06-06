require 'rails_helper'
require 'byebug'
RSpec.describe "Tuits", type: :request do
  describe  "list tuits" do
    let!(:user) { create(:user) }
    let!(:tuits) { create_list(:tweet, 10, user: user) }
    it "Se obtiene tuits" do
      get "/api/tuits"
      get_tuits = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(tuits.size).to eq(get_tuits.size)
    end
  end
  describe "Se obtiene un tuit" do
    let(:user) {create(:user)}
    let(:tuit) {create(:tweet, user: user)}
    it "Tuit correcto" do
      get "/api/tuits/#{tuit.id}"
      get_tuit = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(tuit.id).to eq(get_tuit["id"])
    end

    it "Tuit no existe" do
      get "/api/tuits/65"
      expect(response).to have_http_status(:bad_request)
    end
  end
  describe "tuits for user" do
    let!(:user) {create(:user)}
    let!(:tuits) {create_list(:tweet, 10 ,user: user)}

    it "All tuits for user" do
      get "/api/users/#{user.id}/tuits"
      get_tuits = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(tuits.size).to eq(get_tuits.size)
    end
    it "show tuit for user" do
      tuit = tuits[0]
      get "/api/users/#{user.id}/tuits/#{tuit.id}"
      get_tuit = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(tuit.id).to eq(get_tuit["id"])
    end
  end

  describe "manage tuit with authentication" do
    let!(:user) {create(:user)}
    let!(:tuit) {create(:tweet, user: user)}
    let!(:other_user) {create(:user)}
    let!(:other_tuit) {create(:tweet, user: other_user)}
    let!(:headers) {headers = { "CONTENT_TYPE": "application/json", "X-User-Token": user.authentication_token, "X-User-Email": user.email }}

    it "Create tuit" do
      params = { tweet: {body:"hola como van"} }
      post "/api/tuits",params: params.to_json, headers: headers
      get_tuit = JSON.parse(response.body)
      expect(response).to have_http_status(:created)
      expect(get_tuit["id"]).not_to be_nil
    end

    it "create tuit without authentication" do
      params = { tweet: {body:"hola como van"} }
      post "/api/tuits",params: params.to_json, headers: {"CONTENT_TYPE": "application/json"}
      get_tuit = JSON.parse(response.body)
      expect(response).to have_http_status(:unauthorized)
      expect(get_tuit["id"]).to be_nil
    end

    it "update tuit" do
      params = { tweet: {body:"234"} }
      patch "/api/tuits/#{tuit.id}", params: params.to_json, headers: headers
      get_tuit = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(get_tuit["id"]).not_to be_nil
    end

    it "update tuit without authenticacion" do
      params = { tweet: {body:"234"} }
      patch "/api/tuits/#{tuit.id}", params: params.to_json, headers: {"CONTENT_TYPE": "application/json"}
      expect(response).to have_http_status(:unauthorized)
    end

    it "Actualizar tuit que no es mio" do
      params = { tweet: {body:"234"} }
      patch "/api/tuits/#{other_tuit.id}", params: params.to_json, headers: headers
      expect(response).to have_http_status(:bad_request)
    end
    it "delete tuit" do
      delete "/api/tuits/#{tuit.id}", headers: headers
      respond = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(respond["is_delete"]).to be_truthy
    end
  end
end