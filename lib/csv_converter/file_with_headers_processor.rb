# frozen_string_literal: true

module CSVConverter
  # Iterates over each row and column of the file invoking the converters to transform the data
  class FileWithHeadersProcessor < CSVConverter::FileProcessor
    def process
      rows.map do |row|
        process_rows(row)
      end
    end

    private

    def process_rows(row)
      processed_rows = file_mappings.each_with_object({}) do |(model, model_mappings), hash|
        hash[model] = {} unless hash.key?(model)
        hash[model] = process_cols(row, model_mappings)
      end
      processed_rows
    end

    def process_cols(row, model_mappings)
      model_mappings.each_with_object({}) do |(db_col, col_mappings), hash|
        data = col_value(row, col_mappings[:header])
        hash[db_col] = convert_data(data, col_mappings)
      end
    end

    def convert_data(data, col_mappings)
      converters = col_mappings.dig(:converters)

      return data if converters.blank?

      converters.inject(data) do |d, (target_klass, args)|
        converter(target_klass).new(d, args).process
      end
    end

    def converter(target_klass)
      target_klass = target_klass.to_s

      target_klass = CSVConverter::ALIASES[target_klass] if CSVConverter::ALIASES.keys.include?(target_klass)
      target_klass.constantize
    end

    def col_value(row, csv_header)
      row.to_h.with_indifferent_access[csv_header]
    end
  end
end
