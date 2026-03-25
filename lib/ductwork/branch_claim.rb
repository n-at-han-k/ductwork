# frozen_string_literal: true

module Ductwork
  class BranchClaim
    def initialize(pipeline_klass)
      @pipeline_klass = pipeline_klass
      @claimed_for_advancing_at = nil
    end

    def latest
      id = Ductwork.wrap_with_app_executor do
        Ductwork::Branch
          .in_progress
          .where(pipeline_klass:, claimed_for_advancing_at:)
          .where(steps: Ductwork::Step.where(status: :advancing))
          .where.not(steps: Ductwork::Step.where.not(status: %w[advancing completed]))
          .order(:last_advanced_at)
          .limit(1)
          .pluck(:id)
          .first
      end

      if id.present?
        rows_updated = Ductwork.wrap_with_app_executor do
          Ductwork::Branch
            .where(id:, claimed_for_advancing_at:)
            .update_all(claimed_for_advancing_at: Time.current, status: :advancing)
        end

        if rows_updated == 1
          Ductwork.wrap_with_app_executor do
            Ductwork::Branch.find(id)
          end
        else
          Ductwork.logger.debug(
            msg: "Did not claim branch, avoided race condition",
            branch_id: id,
            pipeline_klass: pipeline_klass,
            role: :pipeline_advancer
          )

          nil
        end
      else
        Ductwork.logger.debug(
          msg: "No branches needs advancing",
          pipeline: pipeline_klass,
          role: :pipeline_advancer
        )

        nil
      end
    end

    private

    attr_reader :pipeline_klass, :claimed_for_advancing_at
  end
end
