# frozen_string_literal: true

module CSVConverter
  # Extracts the value for a column from the csv row and applies conversions to it
  class AttributeProcessor
    attr_reader :row, :data, :attr_mappings, :options

    def initialize(row, attr_mappings, options = {})
      @row            = row
      @attr_mappings  = attr_mappings
      @options        = options
      @data           = row[attr_mappings[:header]]
    end

    def call
      convert_attr(&:call)
    end

    def call!
      convert_attr(&:call!)
    end

    private

    def convert_attr(&block)
      return data if attr_mappings.dig(:converters).blank?

      attr_mappings.dig(:converters).inject(data) do |d, (converter, opts)|
        opts = (opts || {}).merge(options)
        invoke_converter(converter, d, opts, &block)
      end
    end

    def invoke_converter(converter, data, opts)
      return converter.call(data, opts) if converter.is_a?(Proc)

      converter = converter.to_s
      converter = CSVConverter::ALIASES[converter] if CSVConverter::ALIASES.keys.include?(converter)
      converter = converter.constantize.new(data, opts)

      yield(converter)
    end
  end
end
