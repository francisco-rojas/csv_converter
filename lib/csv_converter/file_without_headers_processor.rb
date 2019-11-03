# frozen_string_literal: true

module CSVConverter
  # Iterates over each row and column of the file invoking the converters to transform the data
  class FileWithoutHeadersProcessor < CSVConverter::FileProcessor
    def self.path
      File.expand_path('spec', 'fixtures')
    end
  end
end
