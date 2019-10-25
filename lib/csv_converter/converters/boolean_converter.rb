# frozen_string_literal: true

module CSVConverter
  module Converters
    # Converts a string into a boolean
    class BooleanConverter < BaseConverter
      def process
        data
      end

      private

      def nullable_object
        false
      end
    end
  end
end
