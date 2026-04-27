# frozen_string_literal: true

RSpec.describe "StepErrorsController#index", type: :request do
  describe "GET /ductwork/step_errors" do
    it "renders successfully" do
      create(
        :result,
        result_type: "failure",
        error_klass: "NoMethodError",
        error_message: "undefined method 'fart' called on 'foo'",
        error_backtrace: "(main)"
      )

      get "/ductwork/step_errors"

      expect(response).to have_http_status(:ok)
    end
  end
end
