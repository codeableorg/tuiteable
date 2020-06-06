require 'rails_helper'

describe Api::CommentsController do
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
    @tuit = Tuit.create!(owner: @user, body: 'lorem ipsum')
  end

  describe 'GET to index' do
    it 'returns http status ok' do
      get :index, params: { tuit_id: @tuit }
      expect(response.status).to eq(200)
    end

    it 'render json with all comments' do
      2.times do
        @tuit.comments.create!(user: @user, body: 'comments')
      end
      get :index, params: { tuit_id: @tuit }
      comments = JSON.parse(response.body)
      expect(comments.size).to eq 2
    end
  end

  describe 'GET to show comment' do
    it 'returns http status ok' do
      comment = Comment.create(body: 'New comment', user: @user, tuit: @tuit)
      get :show, params: { tuit_id: @tuit, id: comment }
      expect(response).to have_http_status(:ok)
    end

    it 'render the correct comment' do
      comment = Comment.create(body: 'New comment', user: @user, tuit: @tuit)
      get :show, params: { tuit_id: @tuit, id: comment }
      expected_comment = JSON.parse(response.body)
      expect(expected_comment["id"]).to eql(comment.id)
    end
  end

  describe 'POST to create' do
    before :each do
      @request.headers['X-User-Email'] = @user.email
      @request.headers['X-User-Token'] = @user.authentication_token
    end

    it 'returns http status ok' do
      comment = { body: 'New comment'}
      post :create, params: { tuit_id: @tuit, comment: comment }
      expect(response).to have_http_status(:ok)
    end

    it 'returns the created comment' do
      comment = { body: 'New comment'}
      post :create, params: { tuit_id: @tuit, comment: comment }
      expected_comment = JSON.parse(response.body)
      expect(expected_comment["data"]["body"]).to eql(comment[:body])
    end
  end

  describe 'PATCH to update' do
    before :each do
      @request.headers['X-User-Email'] = @user.email
      @request.headers['X-User-Token'] = @user.authentication_token
    end

    it 'returns http status ok' do
      _comment = Comment.create(body: 'New comment', user: @user, tuit: @tuit)
      comment = { body: 'New comment2' }
      patch :update, params: { tuit_id: @tuit, id: _comment, comment: comment }
      expect(response).to have_http_status(:ok)
    end

    it 'render the updated comment' do
      _comment = Comment.create(body: 'New comment', user: @user, tuit: @tuit)
      comment = { body: 'New comment2' }
      patch :update, params: { tuit_id: @tuit, id: _comment, comment: comment }
      expected_comment = JSON.parse(response.body)
      expect(expected_comment["data"]["id"]).to eql(_comment.id)
    end
  end

  describe 'DELETE to delete' do
    before :each do
      @request.headers['X-User-Email'] = @user.email
      @request.headers['X-User-Token'] = @user.authentication_token
    end

    it 'returns http status no content' do
      comment = Comment.create(body: 'New comment', user: @user, tuit: @tuit)
      delete :destroy, params: { tuit_id: @tuit, id: comment }
      expect(response).to have_http_status(:no_content)
    end

    it 'render the correct comment' do
      Comment.create(body: 'New comment', user: @user, tuit: @tuit)
      comment = Comment.create(body: 'Brand New comment', user: @user, tuit: @tuit)
      delete :destroy, params: { tuit_id: @tuit, id: comment }
      expect(response.body).to eql("")
      expect(Comment.count).to eql(1)
      expect(Comment.exists?(comment.id)).to eql(false)
    end
  end
end
