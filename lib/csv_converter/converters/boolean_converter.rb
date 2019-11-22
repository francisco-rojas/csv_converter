# frozen_string_literal: true

module CSVConverter
  module Converters
    # Converts a string into a boolean
    class BooleanConverter < BaseConverter
      # A new instance of BooleanConverter.
      # @param raw_data [String] the raw data of the attribute being processed.
      # @param options [Hash] the options for the converter provided in the mappings.
      #   Additionally, contains the details of the data being processed. See BaseConverter#option.
      #   The *truthy_values* key is required. If *truthy_values* is blank then an error is raised.
      def initialize(raw_data, options = { truthy_values: %w[true false] })
        super(raw_data, options)

        validate_options
      end

      # Converts *data* into a Boolean by checking if *data*
      # is contained in the list of *truthy_values* provided in the mappings.
      # @return [Boolean] if an error occurs during conversion `false` is returned.
      def call
        call!
      rescue CSVConverter::Error
        nullable_object
      end

      # Converts *data* into a Boolean by checking if *data*
      # is contained in the list of *truthy_values* provided in the mappings.
      # @return [Boolean] if an error occurs during conversion an error is raised.
      def call!
        options[:truthy_values].include?(data)
      rescue StandardError => e
        raise CSVConverter::Error.new(e.message, options)
      end

      private

      def validate_options
        return if options && options[:truthy_values].present?

        raise CSVConverter::Error.new('no `truthy_values` provided', options)
      end

      def nullable_object
        false
      end
    end
  end
end
