# frozen_string_literal: true

module CSVConverter
  module Converters
    # Converts a string into an integer
    class IntegerConverter < BaseConverter
      def process
        process!
      rescue ArgumentError
        nullable_object
      end

      def process!
        Integer(data)
      end

      private

      def nullable_object
        nil
      end
    end
  end
end
