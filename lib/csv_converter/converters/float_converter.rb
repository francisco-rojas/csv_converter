# frozen_string_literal: true

module CSVConverter
  module Converters
    # Converts a string into a float
    class FloatConverter < BaseConverter
      # Converts *data* into a Float.
      # If the decimal separator is a comma it is replaced by a period before parsing.
      # @return [Float] if an error occurs during conversion nil is returned.
      def call
        call!
      rescue CSVConverter::Error
        nullable_object
      end

      # Converts *data* into a Float.
      # If the decimal separator is a comma it is replaced by a period before parsing.
      # @return [Float] if an error occurs during conversion an error is raised.
      def call!
        Float(data.sub(',', '.'))
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
