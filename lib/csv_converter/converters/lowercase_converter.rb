# frozen_string_literal: true

module CSVConverter
  module Converters
    # Converts a string to lowercase
    class LowercaseConverter < BaseConverter
      def call
        call!
      rescue CSVConverter::Error
        nullable_object
      end

      def call!
        raise ArgumentError, 'no data provided' if data.blank?

        data.downcase
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
