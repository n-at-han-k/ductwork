# frozen_string_literal: true

RSpec.describe Ductwork::Branch do
  describe "validations" do
    let(:pipeline_klass) { "MyPipeline" }
    let(:last_advanced_at) { Time.current }
    let(:status) { described_class.statuses.keys.sample }
    let(:started_at) { Time.current }

    it "is invalid if the `pipeline_klass` is not present" do
      branch = described_class.new(
        last_advanced_at:,
        status:,
        started_at:
      )
      branch.pipeline_klass = "                    "

      expect(branch).not_to be_valid
      expect(branch.errors.full_messages.sole).to eq("Pipeline klass can't be blank")
    end

    it "is invalid if the `last_advanced_at` is not present" do
      branch = described_class.new(
        pipeline_klass:,
        status:,
        started_at:
      )

      expect(branch).not_to be_valid
      expect(branch.errors.full_messages.sole).to eq("Last advanced at can't be blank")
    end

    it "is invalid if `status` is not present" do
      branch = described_class.new(
        pipeline_klass:,
        last_advanced_at:,
        started_at:
      )
      branch.status = "\n\n\n\n\n"

      expect(branch).not_to be_valid
      expect(branch.errors.full_messages.sole).to eq("Status can't be blank")
    end

    it "is invalid if `started_at` is not present" do
      branch = described_class.new(
        pipeline_klass:,
        last_advanced_at:,
        status:
      )

      expect(branch).not_to be_valid
      expect(branch.errors.full_messages.sole).to eq("Started at can't be blank")
    end

    it "is valid otherwise" do
      branch = described_class.new(
        pipeline_klass:,
        last_advanced_at:,
        status:,
        started_at:
      )

      expect(branch).to be_valid
    end
  end
end
