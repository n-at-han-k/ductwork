# frozen_string_literal: true

class BackfillBranchIdsOnSteps < Ductwork::Migration
  def up
    Ductwork::Pipeline.find_each do |pipeline|
      branch = Ductwork::Branch.create!(
        pipeline: pipeline,
        pipeline_klass: pipeline.klass,
        status: pipeline.status,
        started_at: pipeline.started_at,
        last_advanced_at: pipeline.last_advanced_at,
        completed_at: pipeline.completed_at
      )
      pipeline.steps.update_all(branch_id: branch.id)
    end
  end

  def down
    Ductwork::Step.update_all(branch_id: nil)
  end
end
