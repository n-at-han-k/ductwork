# frozen_string_literal: true

module Ductwork
  class Tuple < Ductwork::Record
    belongs_to :run, class_name: "Ductwork::Run"

    validates :key, presence: true
    validates :first_set_at, presence: true
    validates :last_set_at, presence: true

    def self.serialize(raw_value)
      { raw_value: }.to_json
    end

    def value=(raw_value)
      self.serialized_value = self.class.serialize(raw_value)
    end

    def value
      if serialized_value.present?
        JSON
          .parse(serialized_value, symbolize_names: true)
          .fetch(:raw_value)
      end
    end
  end
end
