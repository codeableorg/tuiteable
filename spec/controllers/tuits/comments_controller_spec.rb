require 'json'
require 'rails_helper'

describe Api::Tuits::CommentsController do
  before(:each) do
    @user = User.create!(email: 'user@example.com', password: 'password')
    @tuiter = User.create!(email: 'tuiter@example.com', password: 'password')
    @tuit = Tuit.create!(user: @tuiter, body: 'Some random tuit')
    @commenter = User.create!(email: 'commenter@example.com', password: 'password')
    @comment = @tuit.comments.create!(user: @commenter, body: 'Some random comment')
    @comments_count_before = @tuit.comments.size
    request.headers['X-User-Email'] = @user.email
    request.headers['X-User-Token'] = @user.authentication_token
    request.headers['Accept'] = 'application/json'
  end

  context 'GET to index' do
    it 'returns a http status ok' do
      get :index, params: { tuit_id: @tuit.id }
      expect(response).to have_http_status(:ok)
    end

    it 'renders json with all comments' do
      get :index, params: { tuit_id: @tuit.id }
      comments = JSON.parse(response.body)
      expect(comments.size).to eq(1)
    end
  end

  context 'GET to show' do
    it 'returns a http status ok' do
      get :show, params: { tuit_id: @tuit.id, id: @comment.id }
      expect(response).to have_http_status(:ok)
    end

    it 'returns the correct comment' do
      get :show, params: { tuit_id: @tuit.id, id: @comment.id }
      comment = JSON.parse(response.body)
      expect(comment['id']).to eq(@comment.id)
    end

    it 'returns a http status not_found' do
      get :show, params: { tuit_id: 'xxx', id: 'xx' }
      expect(response).to have_http_status(:not_found)
    end
  end
end


describe Api::Tuits::CommentsController do
  before(:each) do
    @user = User.create!(email: 'user@example.com', password: 'password')
    @tuiter = User.create!(email: 'tuiter@example.com', password: 'password')
    @tuit = Tuit.create!(user: @tuiter, body: 'Some random tuit')
    request.headers['X-User-Email'] = @user.email
    request.headers['X-User-Token'] = @user.authentication_token
    request.headers['Accept'] = 'application/json'
  end

  context 'POST to create' do
    it 'returns a http status created' do
      post :create, params: {
        tuit_id: @tuit.id,
        comment: { body: 'Some random comment' },
      }
      expect(response).to have_http_status(:created)
    end

    it 'renders the created comment' do
      post :create, params: {
        tuit_id: @tuit.id,
        comment: { body: 'Some random comment' },
      }
      comment = JSON.parse(response.body)
      expect(comment['id']).to eq(@tuit.comments.last.id)
    end
  end
end

describe Api::Tuits::CommentsController do
  before(:each) do
    @tuiter = User.create!(email: 'tuiter@example.com', password: 'password')
    @tuit = Tuit.create!(user: @tuiter, body: 'Some random tuit')
    @user = User.create!(email: 'user@example.com', password: 'password')
    @comment = @tuit.comments.create!(user: @user, body: 'Some random comment')
    @comments_count_before = @tuit.comments.size
    request.headers['X-User-Email'] = @user.email
    request.headers['X-User-Token'] = @user.authentication_token
    request.headers['Accept'] = 'application/json'
  end

  context 'DELETE to destroy' do
    it 'returns a http status no_content' do
      delete :destroy, params: { tuit_id: @tuit.id, id: @comment.id }
      expect(response).to have_http_status(:no_content)
    end

    it 'returns an empty response' do
      delete :destroy, params: { tuit_id: @tuit.id, id: @comment.id }
      expect(response.body).to be_empty
    end

    it 'decrement by 1 the total of comments' do
      delete :destroy, params: { tuit_id: @tuit.id, id: @comment.id }
      comments_count_after = Tuit.find(@tuit.id).comments_count
      expect(comments_count_after).to eq(@comments_count_before - 1)
    end

    it 'deletes the requested comment' do
      delete :destroy, params: { tuit_id: @tuit.id, id: @comment.id }
      expect { Comment.find(@comment.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
