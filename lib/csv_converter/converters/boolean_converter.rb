# frozen_string_literal: true

module CSVConverter
  module Converters
    # Converts a string into a boolean
    class BooleanConverter < BaseConverter
      def process
        process!
      rescue CSVConverter::Error
        nullable_object
      end

      def process!
        return options[:truthy_values].include?(data) if options[:truthy_values].present?

        raise CSVConverter::Error, 'no `truthy_values` provided'
      end

      private

      def nullable_object
        false
      end
    end
  end
end
