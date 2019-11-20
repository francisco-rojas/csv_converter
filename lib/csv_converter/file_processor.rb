# frozen_string_literal: true

module CSVConverter
  # Iterates over the rows of a file and processes the data accordingly
  class FileProcessor
    attr_reader :filename, :rows, :file_mappings

    def initialize(filename, rows, file_mappings)
      @filename       = filename
      @rows           = rows
      @file_mappings  = file_mappings.with_indifferent_access
    end

    def call
      rows.map.with_index do |row, row_num|
        process_entities(row, row_num, &:call)
      end
    end

    def call!
      rows.map.with_index do |row, row_num|
        process_entities(row, row_num, &:call!)
      end
    end

    private

    def process_entities(row, row_num)
      file_mappings.each_with_object({}) do |(entity, entity_mappings), hash|
        hash[entity] = {} unless hash.key?(entity)
        options = { filename: filename, row_num: row_num, entity: entity, row: row }
        processor = CSVConverter::EntityProcessor.new(row, entity_mappings, options)
        hash[entity] = yield(processor)
      end.with_indifferent_access
    end
  end
end
