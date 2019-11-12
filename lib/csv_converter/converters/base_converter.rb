# frozen_string_literal: true

module CSVConverter
  module Converters
    # Defines the interface that all converters must implement
    class BaseConverter
      def initialize(raw_data, options = {})
        @raw_data   = raw_data.to_s.strip
        @options    = options || {}
      end

      def call
        raise NotImplementedError
      end

      def call!
        raise NotImplementedError
      end

      def data
        @data ||= begin
          return raw_data if raw_data.present? && !empty_value?

          return nullable_object if options.dig(:defaults).blank?

          options.dig(:defaults)
        end
      end

      def empty_value?
        return false unless options.dig(:empty_values)

        options.dig(:empty_values).include?(raw_data)
      end

      private

      attr_reader :raw_data, :options

      def nullable_object
        raise NotImplementedError
      end

      def error_details
        "Error Details: file: '#{options[:filename]}', model: '#{options[:model]}',  column: '#{target_col}', row #: '#{options[:row_num]}'"
      end
    end
  end
end
