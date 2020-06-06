require 'rails_helper'
RSpec.describe "Comments Tuit", type: :request do
  describe "List of comments for tuit" do
    let!(:user) {create(:user)}
    let!(:other_user) {create(:user)}
    let!(:tuit) {create(:tweet, user: user)}
    let!(:comments) {create_list(:comment, 10, user: other_user, tweet: tuit)}
    it "list comments" do
      get "/api/tuits/#{tuit.id}/comments"
      #get "/api/tuits/#{tuit.id}/comments"
      get_comments = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(get_comments.size).to eq(comments.size)
    end
    it "get comment for tuit" do
      comment = comments[1]
      get "/api/tuits/#{tuit.id}/comments/#{comment.id}"
      get_comment = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(get_comment["id"]).to eq(comment.id)
    end
  end

  describe "comments with authentication" do
    let!(:user) {create(:user)}
    let!(:other_user) {create(:user)}
    let!(:tuit) {create(:tweet, user: other_user)}
    let!(:comments) {create_list(:comment, 10, user: user, tweet: tuit)}
    let!(:headers) {headers = { "CONTENT_TYPE": "application/json", "X-User-Token": user.authentication_token, "X-User-Email": user.email }}
    describe "create a comment" do
      it "Create a comment" do
        post "/api/tuits/#{tuit.id}/comments", params: {comment: {body: "is a comment"}}.to_json, headers: headers
        get_comment = JSON.parse(response.body)
        expect(response).to have_http_status(:created)
        expect(get_comment["id"]).not_to be_nil
      end
      it "create a comment without authentication" do
        post "/api/tuits/#{tuit.id}/comments", params: {comment: {body: "is a comment"}}.to_json, headers: {"CONTENT_TYPE": "application/json"}
        get_comment = JSON.parse(response.body)
        expect(response).to have_http_status(:unauthorized)
      end
    end
    describe "update a comment" do
      it "update a comment" do
        comment = comments[1]
        patch "/api/tuits/#{tuit.id}/comments/#{comment.id}", params: {comment: {body: "is a comment"}}.to_json, headers: headers
        get_comment = JSON.parse(response.body)
        expect(get_comment["body"]).to eq("is a comment")
        expect(response).to have_http_status(:ok)
      end
      it "update a comment without to be owner" do
        comment = create(:comment, user: other_user, tweet: tuit)
        patch "/api/tuits/#{tuit.id}/comments/#{comment.id}", params: {comment: {body: "is a comment"}}.to_json, headers: headers
        get_comment = JSON.parse(response.body)
        expect(get_comment["data"]).to be_empty
        expect(response).to have_http_status(:unauthorized)
      end
      it "update a comment" do
        comment = comments[1]
        patch "/api/tuits/#{tuit.id}/comments/#{comment.id}", params: {comment: {body: "is a comment"}}.to_json, headers: {"CONTENT_TYPE": "application/json"}
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end