# frozen_string_literal: true

RSpec.describe "PipelinesController#index", type: :request do
  describe "GET /ductwork/pipelines" do
    it "renders successfully" do
      create(:result)

      get "/ductwork/pipelines"

      expect(response).to have_http_status(:ok)
    end
  end
end
