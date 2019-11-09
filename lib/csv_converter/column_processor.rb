# frozen_string_literal: true

module CSVConverter
  # Extracts the value for a column from the csv row and applies conversions to it
  class ColumnProcessor
    def initialize(row, col_mappings)
      @row          = row
      @col_mappings = col_mappings
    end

    def call
      converters = col_mappings.dig(:converters)

      return data if converters.blank?

      converters.inject(data) do |d, (converter, options)|
        if converter.respond_to?(:call)
          # byebug if options
          converter.call(d, options)
        else
          converter(converter).new(d, options).call
        end
      end
    end

    private

    attr_reader :row, :col_mappings

    def data
      row[col_mappings[:header]]
    end

    def converter(converter)
      converter = converter.to_s

      converter = CSVConverter::ALIASES[converter] if CSVConverter::ALIASES.keys.include?(converter)
      converter.constantize
    end
  end
end
