require 'rails_helper'

RSpec.describe "Explorers", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/explorer/index"
      expect(response).to have_http_status(:success)
    end
  end

end
