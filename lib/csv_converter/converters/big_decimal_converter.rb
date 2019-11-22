# frozen_string_literal: true

require 'bigdecimal'

module CSVConverter
  module Converters
    # Converts a string into a decimal number
    class BigDecimalConverter < BaseConverter
      # Converts *data* into a BigDecimal.
      # If the decimal separator is a comma it is replaced by a period before parsing.
      # @return [BigDecimal] if an error occurs during conversion nil is returned.
      def call
        call!
      rescue CSVConverter::Error
        nullable_object
      end

      # Converts *data* into a BigDecimal.
      # If the decimal separator is a comma it is replaced by a period before parsing.
      # @return [BigDecimal] if an error occurs during conversion an error is raised.
      def call!
        BigDecimal(data.sub(',', '.'))
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
