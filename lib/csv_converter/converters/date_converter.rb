# frozen_string_literal: true

module CSVConverter
  module Converters
    # Converts a string into a date
    class DateConverter < BaseConverter
      def initialize(raw_data, options = {})
        super(raw_data, options)

        raise ArgumentError, 'You must specify a `date_format`' if options[:date_format].blank?
      end

      def process
        process!
      rescue => e
        nullable_object
      end

      def process!
        Date.strptime(data, options[:date_format])
      end

      private

      def nullable_object
        nil
      end
    end
  end
end
