# frozen_string_literal: true

module CSVConverter
  # Iterates over the rows of a file and processes the data accordingly
  class FileProcessor
    def initialize(filename, rows, file_mappings, column_processor: CSVConverter::ColumnProcessor)
      @filename           = filename
      @rows               = rows
      @file_mappings      = file_mappings
      @column_processor   = column_processor
    end

    def call
      rows.map do |row|
        process_rows(row)
      end
    end

    private

    def process_rows(row)
      file_mappings.each_with_object({}) do |(model, model_mappings), hash|
        hash[model] = {} unless hash.key?(model)
        hash[model] = process_cols(row, model_mappings)
      end
    end

    def process_cols(row, model_mappings)
      model_mappings.each_with_object({}) do |(target_col, col_mappings), hash|
        hash[target_col] = column_processor.new(row, col_mappings).call
      end
    end

    attr_reader :filename, :rows, :file_mappings, :column_processor
  end
end
