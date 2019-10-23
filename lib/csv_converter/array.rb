# frozen_string_literal: true

module CSVConverter
  # Converts a string separated by a given char into an array of strings
  class Array < CSVConverter::Base
    def process
      data
    end
  end
end
