# frozen_string_literal: true

module CSVConverter
  module Converters
    # Converts a string with key pair values into ruby hashes
    class HashConverter < BaseConverter
      def initialize(raw_data, options = {})
        super(raw_data, options)

        raise CSVConverter::Error.new('no `item_separator` provided', error_details) if options[:item_separator].nil?
        raise CSVConverter::Error.new('no `key_value_separator` provided', error_details) if options[:key_value_separator].nil?
      end

      def call
        call!
      rescue CSVConverter::Error
        nullable_object
      end

      def call!
        data.split(options[:item_separator]).map do |items|
          items.split(options[:key_value_separator]).map(&:strip)
        end.to_h
      rescue => e
        raise CSVConverter::Error.new(e.message, error_details)
      end

      private

      def nullable_object
        {}
      end
    end
  end
end
