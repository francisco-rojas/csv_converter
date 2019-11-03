# frozen_string_literal: true

module CSVConverter
  # Extracts the value for a column from the csv row and applies conversions to it
  class ColumnProcessor
    def initialize(row, col_mappings)
      @row          = row
      @col_mappings = col_mappings
    end

    def process
      converters = col_mappings.dig(:converters)

      return data if converters.blank?

      converters.inject(data) do |d, (target_class, args)|
        converter(target_class).new(d, args).process
      end
    end

    private

    attr_reader :row, :col_mappings

    def data
      row[col_mappings[:header]]
    end

    def converter(target_class)
      target_class = target_class.to_s

      target_class = CSVConverter::ALIASES[target_class] if CSVConverter::ALIASES.keys.include?(target_class)
      target_class.constantize
    end
  end
end
