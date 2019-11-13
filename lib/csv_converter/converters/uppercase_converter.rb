# frozen_string_literal: true

module CSVConverter
  module Converters
    # Converts a string to uppercase
    class UppercaseConverter < BaseConverter
      def call
        call!
      rescue CSVConverter::Error
        nullable_object
      end

      def call!
        raise ArgumentError, 'no data provided' if data.blank?

        data.upcase
      rescue => e
        raise CSVConverter::Error.new(e.message, error_details)
      end

      private

      def nullable_object
        ''
      end
    end
  end
end
