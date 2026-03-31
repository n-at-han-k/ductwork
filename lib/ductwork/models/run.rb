# frozen_string_literal: true

module Ductwork
  class Run < Ductwork::Record
    belongs_to :pipeline, class_name: "Ductwork::Pipeline"

    validates :pipeline_klass, presence: true
    validates :definition, presence: true
    validates :definition_sha1, presence: true
    validates :status, presence: true
    validates :started_at, presence: true
    validates :triggered_at, presence: true

    enum :status,
         pending: "pending",
         in_progress: "in_progress",
         waiting: "waiting",
         advancing: "advancing",
         halted: "halted",
         dampened: "dampened",
         completed: "completed"
  end
end
