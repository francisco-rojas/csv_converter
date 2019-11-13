# frozen_string_literal: true

require 'bigdecimal'

module CSVConverter
  module Converters
    # Converts a string into a decimal number
    class BigDecimalConverter < BaseConverter
      def call
        call!
      rescue CSVConverter::Error
        nullable_object
      end

      def call!
        BigDecimal(data)
      rescue StandardError => e
        raise CSVConverter::Error.new(e.message, options)
      end

      private

      def nullable_object
        nil
      end
    end
  end
end
