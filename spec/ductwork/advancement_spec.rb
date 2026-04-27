# frozen_string_literal: true

RSpec.describe Ductwork::Advancement do
  describe "validations" do
    it "is invalid if started_at is blank" do
      advancement = described_class.new

      expect(advancement).not_to be_valid
      expect(advancement.errors.full_messages.sole).to eq("Started at can't be blank")
    end

    it "is valid otherwise" do
      advancement = described_class.new(started_at: Time.current)

      expect(advancement).to be_valid
    end
  end
end
