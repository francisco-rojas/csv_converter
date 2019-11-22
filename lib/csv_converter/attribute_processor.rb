# frozen_string_literal: true

module CSVConverter
  # Extracts the value for a column from the csv row and applies conversions to it.
  class AttributeProcessor
    # The row being processed.
    # @return [Array, Hash]
    attr_reader :row

    # The column being processed.
    # @return [String]
    attr_reader :data

    # Attribute mappings.
    # @return [Hash] configuration used to process the data.
    attr_reader :attr_mappings

    # Details of the data being processed. By default this includes:
    #   filename: the name of the file being processed.
    #   row_num: number of the row being processed.
    #   entity: the name of the entity being processed as provided in the mappings.
    #   row: the raw data of the row being processed.
    #   attr: the name of the attribute being processed as provided in the mappings.
    # Additionally it will contain all the options provided to the converter in the mappings.
    # @return [Hash]
    attr_reader :options

    # A new instance of AttributeProcessor.
    # @param row (@see #row)
    # @param attr_mappings (@see #attr_mappings)
    # @param options (@see #options)
    def initialize(row, attr_mappings, options = {})
      @row            = row
      @attr_mappings  = attr_mappings
      @options        = options
      @data           = row[attr_mappings[:header]]
    end

    # Converts the data of the attribute into the type provided in the mappings by invoking the converters.
    # @return [Object] an object of the expected type.
    #   If an error occurs during conversion the nullable value for the attributes is returned.
    def call
      convert_attr(&:call)
    end

    # Converts the data of the attribute into the type provided in the mappings by invoking the converters.
    # @return [Object] an object of the expected type.
    #   If an error occurs during conversion an error is raised.
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
