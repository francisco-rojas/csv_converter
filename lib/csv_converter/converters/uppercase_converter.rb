# frozen_string_literal: true

module CSVConverter
  module Converters
    # Converts a string to uppercase
    class UppercaseConverter < BaseConverter
      def process
        process!.upcase
      rescue ArgumentError
        nullable_object
      end

      def process!
        raise ArgumentError, 'no data provided' if data.blank?

        data
      end

      private

      def nullable_object
        ''
      end
    end
  end
end
