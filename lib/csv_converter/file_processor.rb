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
      rows.map do |row|
        process_rows(row)
      end
    end

    private

    def process_rows(row)
      processed_rows = file_mappings.each_with_object({}) do |(model, row_mappings), hash|
        hash[model] = {} unless hash.key?(model)
        hash[model] = process_cols(row, row_mappings)
      end
      processed_rows
    end

    def process_cols(row, cols_mappings)
      cols_mappings.each_with_object({}) do |(db_col, col_mappings), hash|
        data = col_value(row, col_mappings[:header])
        hash[db_col] = convert_data(data, converters(col_mappings))
      end
    end

    def convert_data(data, converters)
      return data if converters.blank?

      converters.inject(data) do |d, (klass, args)|
        klass.new(d, args).process
      end
    end

    def col_value(row, csv_header)
      row.to_h.with_indifferent_access[csv_header]
    end

    def converters(col_mappings)
      converters = col_mappings.dig(:converters)

      converters.each_with_object({}) do |(klass, args), constantized_hash|
        constantized_hash[klass.to_s.constantize] = args
      end
    end

    attr_reader :filename, :rows, :file_mappings
  end
end
