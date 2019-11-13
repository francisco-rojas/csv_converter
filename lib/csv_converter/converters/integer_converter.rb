# frozen_string_literal: true

module CSVConverter
  module Converters
    # Converts a string into an integer
    class IntegerConverter < BaseConverter
      def call
        call!
      rescue CSVConverter::Error
        nullable_object
      end

      def call!
        Integer(data)
      rescue => e
        raise CSVConverter::Error.new(e.message, error_details)
      end

      private

      def nullable_object
        nil
      end
    end
  end
end
