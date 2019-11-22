# frozen_string_literal: true

module CSVConverter
  module Converters
    # Converts a string into an integer
    class IntegerConverter < BaseConverter
      # Converts *data* into an Integer.
      # @return [Integer] if an error occurs during conversion nil is returned.
      def call
        call!
      rescue CSVConverter::Error
        nullable_object
      end

      # Converts *data* into an Integer.
      # @return [Integer] if an error occurs during conversion an error is raised.
      def call!
        Integer(data)
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
