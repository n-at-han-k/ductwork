# frozen_string_literal: true

RSpec.describe "DashboardsController#show", type: :request do
  describe "GET /ductwork" do
    it "render successfully" do
      create(:result)

      get "/ductwork"

      expect(response).to have_http_status(:ok)
    end
  end
end
