# frozen_string_literal: true

module CSVConverter
  module Converters
    # Converts a string into a boolean
    class BooleanConverter < BaseConverter
      def initialize(raw_data, options = {})
        super(raw_data, options)

        raise ArgumentError, 'no `truthy_values` provided' if options[:truthy_values].blank?
      end

      def call
        call!
      rescue CSVConverter::Error
        nullable_object
      end

      def call!
        options[:truthy_values].include?(data)
      end

      private

      def nullable_object
        false
      end
    end
  end
end
