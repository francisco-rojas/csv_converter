# frozen_string_literal: true

module CSVConverter
  module Converters
    # Cleans up a string
    class StringConverter < BaseConverter
      def process
        process!
      rescue ArgumentError
        nullable_object
      end

      def process!
        raise ArgumentError, 'no data provided' if data.blank?

        data
      end

      private

      def nullable_object
        ''
      end
    end
  end
end
