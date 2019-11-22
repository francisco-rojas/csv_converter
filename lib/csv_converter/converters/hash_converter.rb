# frozen_string_literal: true

module CSVConverter
  module Converters
    # Converts a string with key pair values into ruby hashes
    class HashConverter < BaseConverter
      # A new instance of HashConverter.
      # @param raw_data [String] the raw data of the attribute being processed.
      # @param options [Hash] the options for the converter provided in the mappings.
      #   Additionally, contains the details of the data being processed. See BaseConverter#option.
      #   The *item_separator* key is required. If *item_separator* is nil then an error is raised.
      #   The *key_value_separator* key is required. If *key_value_separator* is nil then an error is raised.
      def initialize(raw_data, options = {})
        super(raw_data, options)

        validate_options
      end

      # Converts *data* into a hash by splitting the string on the *item_separator* to get the items
      # and then by spliting the items on *key_value_separator* to get the key/value.
      # @return [Hash] if an error occurs during conversion an empty hash is returned.
      def call
        call!
      rescue CSVConverter::Error
        nullable_object
      end

      # Converts *data* into a hash by splitting the string on the *item_separator* to get the items
      # and then by spliting the items on *key_value_separator* to get the key/value.
      # @return [Hash] if an error occurs during conversion an error is raised.
      def call!
        data.split(options[:item_separator]).map do |items|
          items.split(options[:key_value_separator]).map(&:strip)
        end.to_h
      rescue StandardError => e
        raise CSVConverter::Error.new(e.message, options)
      end

      private

      def validate_options
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
