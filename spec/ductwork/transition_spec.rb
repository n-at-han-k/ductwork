# frozen_string_literal: true

RSpec.describe Ductwork::Transition do
  describe "validations" do
    it "is invalid if started_at is blank" do
      transition = described_class.new

      expect(transition).not_to be_valid
      expect(transition.errors.full_messages.sole).to eq("Started at can't be blank")
    end

    it "is valid otherwise" do
      transition = described_class.new(started_at: Time.current)

      expect(transition).to be_valid
    end
  end
end
