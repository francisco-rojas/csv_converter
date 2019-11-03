# frozen_string_literal: true

module CSVConverter
  # Iterates over each row and column of the file invoking the converters to transform the data
  class FileProcessor
    def initialize(filename, rows, file_mappings)
      @filename       = filename
      @rows           = rows
      @file_mappings  = file_mappings
    end

    def process
      raise NotImplementedError
    end

    private

    attr_reader :filename, :rows, :file_mappings
  end
end
