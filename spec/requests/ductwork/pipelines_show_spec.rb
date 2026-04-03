# frozen_string_literal: true

RSpec.describe "PipelinesController#show", type: :request do
  describe "GET /ductwork/pipelines/:id" do
    it "renders successfully" do
      result = create(:result)
      create(:availability, execution: result.execution)
      create(:attempt, execution: result.execution)
      pipeline_id = result.execution.job.step.run.pipeline_id

      get "/ductwork/pipelines/#{pipeline_id}"

      expect(response).to have_http_status(:ok)
    end
  end
end
