# frozen_string_literal: true

module CSVConverter
  module Converters
    # Cleans up a string
    class StringConverter < BaseConverter
      # Cleans up the *data* string.
      # @return [String] if *data* is empty returns an empty string.
      def call
        call!
      rescue CSVConverter::Error
        nullable_object
      end

      # Cleans up the *data* string.
      # @return [String] if *data* is empty an error is raised.
      def call!
        raise ArgumentError, 'no data provided' if data.blank?

        data
      rescue StandardError => e
        raise CSVConverter::Error.new(e.message, options)
      end

      private

      def nullable_object
        ''
      end
    end
  end
end
