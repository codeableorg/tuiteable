class API::TuitsController < ApiController
  describe 'GET to index' do
    it 'returns http status ok' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'render json with all tuits' do
      Tuit.create(body: "Tuit test", user:)
      get :index
      games = JSON.parse(response.body)
      expect(games.size).to eq 1
    end
  end

  describe 'GET to show' do
    it 'returns http status ok' do
      game = Game.create(name: 'New Game', category: "main_game")
      get :show, params: { id: game }
      expect(response).to have_http_status(:ok)
    end

    it 'render the correct game' do
      game = Game.create(name: 'New Game', category: "main_game")
      get :show, params: { id: game }
      expected_game = JSON.parse(response.body)
      expect(expected_game["id"]).to eql(game.id)
    end

    it 'returns http status not found' do
      get :show, params: { id: 'xxx' }
      expect(response).to have_http_status(:not_found)
    end
  end
end