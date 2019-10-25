# frozen_string_literal: true

module CSVConverter
  module Converters
    # Converts a string separated by a given char into an array of strings
    class ArrayConverter < BaseConverter
      def process
        process!
      rescue CSVConverter::Error
        nullable_object
      end

      def process!
        return data.gsub(' ', '').split(options[:separator]) if options[:separator].present?

        raise CSVConverter::Error, 'a `separator` must be provided in order to split the string'
      end

      private

      def nullable_object
        []
      end
    end
  end
end