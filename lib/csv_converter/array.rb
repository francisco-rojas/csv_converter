# frozen_string_literal: true

module CSVConverter
  # Converts a string separated by a given char into an array of strings
  class Array < CSVConverter::Base
    def process
      process!
    rescue CSVConverter::Error
      [data]
    end

    def process!
      return data.gsub(' ', '').split(options[:separator]) if options[:separator].present?

      raise CSVConverter::Error, 'a `separator` must be provided in order to split the string'
    end

    private

    def nullable_object
      []
    end
  end
end
