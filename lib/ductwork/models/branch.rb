# frozen_string_literal: true

module Ductwork
  class Branch < Ductwork::Record
    belongs_to :pipeline, class_name: "Ductwork::Pipeline"
    has_many :steps,
             class_name: "Ductwork::Step",
             foreign_key: "branch_id",
             dependent: :destroy
    has_many :parent_junctions,
             class_name: "Ductwork::BranchJunction",
             foreign_key: "child_branch_id",
             dependent: :destroy
    has_many :child_junctions,
             class_name: "Ductwork::BranchJunction",
             foreign_key: "parent_branch_id",
             dependent: :destroy
    has_many :parent_branches, through: :parent_junctions, source: :parent_branch
    has_many :child_branches, through: :child_junctions, source: :child_branch

    validates :last_advanced_at, presence: true
    validates :pipeline_klass, presence: true
    validates :status, presence: true
    validates :started_at, presence: true

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
