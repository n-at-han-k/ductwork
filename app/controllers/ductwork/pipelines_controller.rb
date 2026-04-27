# frozen_string_literal: true

module Ductwork
  class PipelinesController < Ductwork::ApplicationController
    def index
      @runs = query_pipeline_runs
      @klasses = Ductwork::Pipeline.group(:klass).pluck(:klass).sort
      @statuses = Ductwork::Pipeline.statuses.keys
    end

    def show
      @pipeline = Ductwork::Pipeline.find(params[:id])
      @last_run = @pipeline.runs.order(started_at: :desc).first
      @per_page = 10
      @steps = query_steps
      @klasses = @last_run.steps.group(:klass).pluck(:klass).sort
      @statuses = Ductwork::Step.statuses.keys
    end

    private

    def query_steps
      @last_run
        .steps
        .then(&method(:filter_by_klass))
        .then(&method(:filter_by_status))
        .then(&method(:paginate))
        .order(:started_at)
    end
  end
end
