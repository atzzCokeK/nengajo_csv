# frozen_string_literal: true

module Csv
  class HeaderAnalyzer
    def initialize(headers:, template:)
      @headers = headers
      @template = template
    end

    def analyze
      mapped = {}
      mapping = @template["mapping"]

      @headers.each do |header|
        mapped[header] = mapping[header] if mapping.key?(header)
      end

      expected = mapping.values.uniq

      {
        mapped: mapped,
        missing: expected - mapped.values,
        extra: @headers - mapping.keys
      }
    end
  end
end
