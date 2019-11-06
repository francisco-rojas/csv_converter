# frozen_string_literal: true

module CSVConverter
  module Converters
    # Converts a string into an integer
    class IntegerConverter < BaseConverter
      def call
        call!
      rescue ArgumentError
        nullable_object
      end

      def call!
        Integer(data)
      end

      private

      def nullable_object
        nil
      end
    end
  end
end
