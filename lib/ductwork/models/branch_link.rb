# frozen_string_literal: true

module Ductwork
  class BranchLink < Ductwork::Record
    belongs_to :parent_branch, class_name: "Ductwork::Branch"
    belongs_to :child_branch, class_name: "Ductwork::Branch"

    validates :parent_branch_id, uniqueness: { scope: :child_branch_id }
  end
end
