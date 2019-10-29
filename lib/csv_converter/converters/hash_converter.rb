# frozen_string_literal: true

module CSVConverter
  module Converters
    # Converts a string with key pair values into ruby hashes
    class HashConverter < BaseConverter
      def initialize(raw_data, options = {})
        super(raw_data, options)

        raise ArgumentError, 'no `item_separator` provided' if options[:item_separator].nil?
        raise ArgumentError, 'no `key_value_separator` provided' if options[:key_value_separator].nil?
      end

      def process
          process!
        rescue ArgumentError
          nullable_object
      end

      def process!
        data.split(options[:item_separator]).map do |items|
          items.split(options[:key_value_separator]).map(&:strip)
        end.to_h
      end

      # private

      def nullable_object
        {}
      end
    end
  end
end
