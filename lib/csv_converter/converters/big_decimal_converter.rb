# frozen_string_literal: true
require 'bigdecimal'

module CSVConverter
  module Converters
    # Converts a string into a decimal number
    class BigDecimalConverter < BaseConverter
      def process
        process!
      rescue ArgumentError
        nullable_object
      end

      def process!
        BigDecimal(data)
      end

      private

      def nullable_object
        0.0
      end
    end
  end
end
