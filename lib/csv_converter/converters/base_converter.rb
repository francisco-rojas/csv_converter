# frozen_string_literal: true

module CSVConverter
  module Converters
    # Defines the interface that all converters must implement
    class BaseConverter
      # @return [String] the raw data of the attribute being processed.
      attr_reader :raw_data
      # Details of the data being processed. By default this includes:
      #   filename: the name of the file being processed
      #   row_num: number of the row being processed
      #   entity: the name of the entity being processed as provided in the mappings
      #   row: the raw data of the row being processed
      #   attr: the name of the attribute being processed as provided in the mappings
      # Additionally it contains all the options provided to the converter in the mappings.
      # @return [Hash]
      attr_reader :options

      # A new instance of BaseConverter.
      # @param raw_data [String] the raw data of the attribute being processed.
      # @param options [Hash] the options for the converter provided in the mappings.
      #   Additionally, contains the details of the data being processed.
      def initialize(raw_data, options = {})
        @raw_data   = raw_data.to_s.strip
        @options    = options || {}
      end

      # Converts raw_data into the type specified in the mappings.
      # Must be implemented by children
      def call
        raise NotImplementedError
      end

      # Converts raw_data into the type specified in the mappings.
      # Must be implemented by children
      def call!
        raise NotImplementedError
      end

      # Evaluates raw_data and returns the proper value for it.
      # @return [String]
      #   If raw_data is not empty returns raw_data.
      #   If raw_data is empty and no default value is provided in the mappings returns the nullable object.
      #   If raw_data is empty and a default value is provided in the mappings returns the default value.
      def data
        @data ||= begin
          return raw_data if raw_data.present? && !empty_value?

          return nullable_object if options.dig(:default).blank?

          options.dig(:default)
        end
      end

      # Checks if raw_data is contained in the list of *empty_values* provided in the mapping.
      # @return [Boolean]
      def empty_value?
        return false unless options.dig(:empty_values)

        options.dig(:empty_values).include?(raw_data)
      end

      private

      def nullable_object
        raise NotImplementedError
      end
    end
  end
end
