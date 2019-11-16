# frozen_string_literal: true

module CSVConverter
  module Converters
    # Converts a string separated by a given char into an array of strings
    class ArrayConverter < BaseConverter
      def initialize(raw_data, options = {})
        super(raw_data, options)

        raise CSVConverter::Error.new('no `separator` provided', options) if options[:separator].blank?
      end

      def call
        call!
      rescue CSVConverter::Error
        nullable_object
      end

      def call!
        data.split(options[:separator]).map(&:strip)
      rescue StandardError => e
        raise CSVConverter::Error.new(e.message, options)
      end

      private

      def nullable_object
        []
      end
    end
  end
end
