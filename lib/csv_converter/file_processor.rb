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
      rows.map.with_index do |row, row_num|
        process_rows(row, row_num)
      end
    end

    private

    def process_rows(row, row_num)
      file_mappings.each_with_object({}) do |(model, model_mappings), hash|
        hash[model] = {} unless hash.key?(model)
        hash[model] = if model_mappings[:nested]
                        process_nested_row(row, model_mappings, row_num, model)
                      else
                        process_cols(row, model_mappings, row_num, model)
                      end
      end
    end

    # when csv is nested in a column
    # split the column data by the specified separator before processing
    def process_nested_row(row, model_mappings, row_num, model)
      nested_row = row[model_mappings[:header]]
      separator  = model_mappings[:separator] || ','
      process_cols(nested_row.split(separator), model_mappings[:mappings], row_num, model)
    end

    def process_cols(row, model_mappings, row_num, model)
      model_mappings.each_with_object({}) do |(target_col, col_mappings), hash|
        stats = { filename: filename, row_num: row_num, model: model, target_col: target_col }
        hash[target_col] = column_processor.new(row, col_mappings, stats).call
      end
    end

    attr_reader :filename, :rows, :file_mappings, :column_processor
  end
end
