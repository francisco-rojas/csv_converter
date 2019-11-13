# frozen_string_literal: true

module CSVConverter
  module Converters
    # Converts a string into a boolean
    class BooleanConverter < BaseConverter
      def initialize(raw_data, options = {})
        super(raw_data, options)

        raise CSVConverter::Error.new('no `truthy_values` provided', options) if options[:truthy_values].blank?
      end

      def call
        call!
      rescue CSVConverter::Error
        nullable_object
      end

      def call!
        options[:truthy_values].include?(data)
      rescue StandardError => e
        raise CSVConverter::Error.new(e.message, options)
      end

      private

      def nullable_object
        false
      end
    end
  end
end
