# frozen_string_literal: true

module CSVConverter
  module Converters
    # Converts a string into a date
    class DateConverter < BaseConverter
      def initialize(raw_data, options = {})
        super(raw_data, options)

        raise CSVConverter::Error.new('no `date_format` provided', options) if options[:date_format].blank?
      end

      def call
        call!
      rescue CSVConverter::Error
        nullable_object
      end

      def call!
        Date.strptime(data, options[:date_format])
      rescue StandardError => e
        raise CSVConverter::Error.new(e.message, options)
      end

      private

      def nullable_object
        nil
      end
    end
  end
end
