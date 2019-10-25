# frozen_string_literal: true

module CSVConverter
  module Converters
    # Cleans up a string
    class StringConverter < BaseConverter
      def process
        data
      end

      private

      def nullable_object
        ''
      end
    end
  end
end
