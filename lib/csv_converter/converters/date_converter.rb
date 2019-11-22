# frozen_string_literal: true

module CSVConverter
  module Converters
    # Converts a string into a date
    class DateConverter < BaseConverter
      # A new instance of DateConverter.
      # @param raw_data [String] the raw data of the attribute being processed.
      # @param options [Hash] the options for the converter provided in the mappings.
      #   Additionally, contains the details of the data being processed. See BaseConverter#option.
      #   The *date_format* key is required. If *date_format* is blank then an error is raised.
      def initialize(raw_data, options = { date_format: '%m/%d/%y' })
        super(raw_data, options)

        validate_options
      end

      # Converts *data* into a Date using the format provided in the mappings.
      # @return [Date] if an error occurs during conversion `nil` is returned.
      def call
        call!
      rescue CSVConverter::Error
        nullable_object
      end

      # Converts *data* into a Date using the format provided in the mappings.
      # @return [Date] if an error occurs during conversion an error is raised.
      def call!
        Date.strptime(data, options[:date_format])
      rescue StandardError => e
        raise CSVConverter::Error.new(e.message, options)
      end

      private

      def validate_options
        return if options && options[:date_format].present?

        raise CSVConverter::Error.new('no `date_format` provided', options)
      end

      def nullable_object
        nil
      end
    end
  end
end
