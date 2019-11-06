# frozen_string_literal: true

module CSVConverter
  module Converters
    # Converts a string into a float
    class FloatConverter < BaseConverter
      def call
        call!
      rescue ArgumentError
        nullable_object
      end

      def call!
        Float(data)
      end

      private

      def nullable_object
        nil
      end
    end
  end
end
