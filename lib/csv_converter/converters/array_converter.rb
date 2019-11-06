# frozen_string_literal: true

module CSVConverter
  module Converters
    # Converts a string separated by a given char into an array of strings
    class ArrayConverter < BaseConverter
      def initialize(raw_data, options = {})
        super(raw_data, options)

        raise ArgumentError, 'no `separator` provided' if options[:separator].blank?
      end

      def call
        call!
      rescue CSVConverter::Error
        nullable_object
      end

      def call!
        data.gsub(' ', '').split(options[:separator])
      end

      private

      def nullable_object
        []
      end
    end
  end
end
