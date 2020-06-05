require 'rails_helper'

describe Api::TuitsController do
  before :all do
    @user = User.create(name:'User Example', username:'@userexample',email:'user@example.com', bio:'Hi5!', password:123123)
    @tuit = Tuit.create(body:'Tuit example', user_id: @user.id)
    @params_second_user = {name:'User Example 2', username:'@userexample2',email:'user2@example.com', bio:'Hi5!', password:123123}
    @params_second_tuit = {body:'Tuit example 2', user: @user}
    puts '**********************'
    puts @user.email
    puts '**********************'
  end

  describe 'GET to index' do
    it 'returns http status ok' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'render json with all tuits' do
      get :index
      tuits = JSON.parse(response.body)
      expect(tuits.size).to eq 1
    end
  end

  describe 'GET to show' do
    it 'returns http status ok' do
      get :show, params: { id: @tuit.id }
      expect(response).to have_http_status(:ok)
    end

    it 'render the correct tuit' do
      get :show, params: { id: @tuit.id }
      expected_tuit = JSON.parse(response.body)
      expect(expected_tuit["id"]).to eql(@tuit.id)
    end

    it 'returns http status not found' do
      get :show, params: { id: 'xxx' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST to create' do
    it 'returns http status unauthorized if there is no correct header' do
      post :create, params: { tuit: @params_second_tuit }
      expect(response).to have_http_status(:created)
    end

    it 'returns http status created' do
      request.headers['X-User-Token'] = @user.authentication_token
      request.headers['X-User-Email'] = @user.email
      post :create, params: { tuit: @params_second_tuit }
      expect(response).to have_http_status(:created)
    end

    it 'returns the created tuit' do
      request.headers['X-User-Token'] = @user.authentication_token
      request.headers['X-User-Email'] = @user.email
      expect{post :create, params: { tuit: @params_second_tuit }}.to change(Tuit, :count).by(1)
    end
  end

  describe 'PATCH to update' do
    it 'returns http status unauthorized if there is no correct header' do
      my_params = {body: 'Example edited'}
      patch :update, params: { id: @tuit.id, tuit: my_params }
      expect(response).to have_http_status(:ok)
    end

    it 'returns http status ok' do
      my_params = {body: 'Example edited'}
      request.headers['X-User-Token'] = @user.authentication_token
      request.headers['X-User-Email'] = @user.email
      patch :update, params: { id: @tuit.id, tuit: my_params }
      expect(response).to have_http_status(:ok)
    end

    it 'returns the updated tuit' do
      my_params = {body: 'Example edited'}
      request.headers['X-User-Token'] = @user.authentication_token
      request.headers['X-User-Email'] = @user.email
      patch :update, params: { id: @tuit.id, tuit: my_params }
      expected_tuit = JSON.parse(response.body)
      expect(expected_tuit["id"]).to eql(@tuit.id)
    end
  end

  describe 'DELETE to destroy' do
    it 'returns http status unauthorized if there is no correct header' do
      expect(delete :destroy, params: { id: @tuit.id }).to have_http_status(:no_content)
    end

    it 'returns http status no content' do
      request.headers['X-User-Token'] = @user.authentication_token
      request.headers['X-User-Email'] = @user.email
      expect(delete :destroy, params: { id: @tuit.id }).to have_http_status(:no_content)
    end

    it 'returns empty body' do
      request.headers['X-User-Token'] = @user.authentication_token
      request.headers['X-User-Email'] = @user.email
      delete :destroy, params: { id: @tuit.id }
      expect(response.body).to be_empty
    end

    it 'decrement by 1 the total of tuits' do
      request.headers['X-User-Token'] = @user.authentication_token
      request.headers['X-User-Email'] = @user.email
      expect{delete :destroy, params: { id: @tuit.id }}.to change(Tuit, :count).by(-1)
    end

    it 'delete the requested tuit' do
      request.headers['X-User-Token'] = @user.authentication_token
      request.headers['X-User-Email'] = @user.email
      delete :destroy, params: { id: @tuit.id }
      expected_tuit = Tuit.find_by(id: @tuit.id)
      expect(expected_tuit).to be_nil
    end
  end
end