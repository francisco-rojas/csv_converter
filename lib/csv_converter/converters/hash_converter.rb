# frozen_string_literal: true

module CSVConverter
  module Converters
    # Converts a string with key pair values into ruby hashes
    class HashConverter < BaseConverter
      def initialize(raw_data, options = {})
        super(raw_data, options)

        validate
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
      rescue StandardError => e
        raise CSVConverter::Error.new(e.message, options)
      end

      private

      def validate
        validate_separator
        validate_key_value_separator
      end

      def validate_separator
        return unless options[:item_separator].nil?

        raise CSVConverter::Error.new('no `item_separator` provided', options)
      end

      def validate_key_value_separator
        return unless options[:key_value_separator].nil?

        raise CSVConverter::Error.new('no `key_value_separator` provided', options)
      end

      def nullable_object
        {}
      end
    end
  end
end
