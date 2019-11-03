# frozen_string_literal: true

module CSVConverter
  # Iterates over each row and column of the file invoking the converters to transform the data
  class FileWithoutHeadersProcessor < CSVConverter::FileProcessor
    def process
      rows.map do |row|
        process_rows(row)
      end
    end

    private

    def col_value(row, csv_header)
      row[csv_header]
    end
  end
end
