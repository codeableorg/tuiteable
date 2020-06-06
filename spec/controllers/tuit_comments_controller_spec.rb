require 'rails_helper'

describe Api::TuitCommentsController do
  before :each do
    @user = User.create(name:'User Example', username:'@example1',email:'example1@example.com', bio:'Hi5!', password:123123)
    @tuit = Tuit.create(body:'Tuit example', user_id: @user.id)
    @comment = Comment.create(user_id:@user.id, tuit:@tuit, body:'Comment 1')
    @params_second_comment = { tuit_id:@tuit.id, body:'Comment 2' }
  end

  describe 'GET to user_tuits' do
    it 'returns http status ok' do
      get :tuit_comments, params: {tuit_id: @tuit.id}
      expect(response.status).to eq(200)
    end

    it 'render json with all comments for a tuit' do
      get :tuit_comments, params: {tuit_id: @tuit.id}
      comments = JSON.parse(response.body)
      expect(comments.size).to eq 1
    end
  end

  describe 'GET to show_tuit_comments' do
    it 'returns http status ok' do
      get :show_tuit_comment, params: {tuit_id: @tuit.id, comment_id: @comment.id}
      expect(response).to have_http_status(:ok)
    end

    it 'render the correct comment of a tuit' do
      get :show_tuit_comment, params: {tuit_id: @tuit.id, comment_id: @comment.id}
      expected_comment = JSON.parse(response.body)
      expect(expected_comment["id"]).to eql(@comment.id)
    end

    it 'returns http status not found' do
      get :show_tuit_comment, params: {tuit_id: @tuit.id, comment_id: 'xxx'}
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST to create_comment' do
    it 'returns http status found to redirect if there is no correct header' do
      post :create, params: @params_second_comment
      expect(response).to have_http_status(:found)
    end

    it 'returns http status created' do
      request.headers['X-User-Token'] = @user.authentication_token
      request.headers['X-User-Email'] = @user.email
      post :create, params: @params_second_comment
      expect(response).to have_http_status(:created)
    end

    it 'returns the created comment' do
      request.headers['X-User-Token'] = @user.authentication_token
      request.headers['X-User-Email'] = @user.email
      expect{post :create, params: @params_second_comment}.to change(Comment, :count).by(1)
    end
  end

  describe 'DELETE to destroy' do
    it 'returns http status found to redirect if there is no correct header' do
      expect(delete :destroy, params: { tuit_id:@tuit.id, comment_id: @comment.id }).to have_http_status(:found)
    end

    it 'returns http status no content' do
      request.headers['X-User-Token'] = @user.authentication_token
      request.headers['X-User-Email'] = @user.email
      expect(delete :destroy, params: { tuit_id:@tuit.id, comment_id: @comment.id }).to have_http_status(:no_content)
    end

    it 'returns empty body' do
      request.headers['X-User-Token'] = @user.authentication_token
      request.headers['X-User-Email'] = @user.email
      delete :destroy, params: { tuit_id:@tuit.id, comment_id: @comment.id }
      expect(response.body).to be_empty
    end

    it 'decrement by 1 the total of comments' do
      request.headers['X-User-Token'] = @user.authentication_token
      request.headers['X-User-Email'] = @user.email
      expect{delete :destroy, params: { tuit_id:@tuit.id, comment_id: @comment.id }}.to change(Comment, :count).by(-1)
    end
  end
end