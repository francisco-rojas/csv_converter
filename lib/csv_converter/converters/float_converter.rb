# frozen_string_literal: true

module CSVConverter
  module Converters
    # Converts a string into a float
    class FloatConverter < BaseConverter
      def call
        call!
      rescue CSVConverter::Error
        nullable_object
      end

      def call!
        Float(data)
      rescue => e
        raise CSVConverter::Error.new(e.message, error_details)
      end

      private

      def nullable_object
        nil
      end
    end
  end
end
