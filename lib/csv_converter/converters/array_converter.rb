# frozen_string_literal: true

module CSVConverter
  module Converters
    # Converts a string separated by a given char into an array of strings.
    class ArrayConverter < BaseConverter
      # A new instance of ArrayConverter.
      # @param raw_data [String] the raw data of the attribute being processed.
      # @param options [Hash] the options for the converter provided in the mappings.
      #   Additionally, contains the details of the data being processed. See BaseConverter#option.
      #   The *separator* key is required. If *separator* is nil then an error is raised.
      def initialize(raw_data, options = { separator: ',' })
        super(raw_data, options)

        validate_options
      end

      # Converts *data* into an array by splitting the string on the *separator* provided in the mappings.
      # @return [Array] if an error occurs during conversion an empty array is returned.
      def call
        call!
      rescue CSVConverter::Error
        nullable_object
      end

      # Converts *data* into an array by splitting the string on the *separator* provided in the mappings.
      # @return [Array] if an error occurs during conversion an error is raised.
      def call!
        data.split(options[:separator]).map(&:strip)
      rescue StandardError => e
        raise CSVConverter::Error.new(e.message, options)
      end

      private

      def validate_options
        return if options && !options[:separator].nil?

        raise CSVConverter::Error.new('no `key_value_separator` provided', options)
      end

      def nullable_object
        []
      end
    end
  end
end
