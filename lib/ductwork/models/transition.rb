# frozen_string_literal: true

module Ductwork
  class Transition < Ductwork::Record
    belongs_to :branch, class_name: "Ductwork::Branch"
    belongs_to :in_step, class_name: "Ductwork::Step"
    belongs_to :out_step, class_name: "Ductwork::Step", optional: true
    has_many :advancements,
             class_name: "Ductwork::Advancement",
             foreign_key: "transition_id",
             dependent: :destroy

    validates :started_at, presence: true
  end
end
