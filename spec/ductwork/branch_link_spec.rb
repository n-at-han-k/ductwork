# frozen_string_literal: true

RSpec.describe Ductwork::BranchLink do
  describe "validations" do
    it "is invalid if the parent and child branch id tuple is not unique" do
      parent_branch = create(:branch)
      child_branch = create(:branch)
      junction = described_class.new(parent_branch:, child_branch:)

      described_class.create!(parent_branch:, child_branch:)

      expect(junction).not_to be_valid
      expect(junction.errors.full_messages.sole).to eq("Parent branch has already been taken")
    end
  end
end
