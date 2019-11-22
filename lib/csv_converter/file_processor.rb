# frozen_string_literal: true

module CSVConverter
  # Iterates over a collection and processes the data accordingly.
  class FileProcessor
    # Name of the file being processed.
    # @return [String] the name of the file.
    attr_reader :filename

    # Collection being processed.
    # @return [Array] collection of rows being processed.
    attr_reader :rows

    # File mappings.
    # @return [Hash] configuration used to process the data.
    attr_reader :file_mappings

    # A new instance of FileProcessor.
    # @param filename (@see #filename)
    # @param rows (@see #rows)
    # @param file_mappings (@see #file_mappings)
    def initialize(filename, rows, file_mappings)
      @filename       = filename
      @rows           = rows
      @file_mappings  = file_mappings.with_indifferent_access
    end

    # Iterates over the rows grouping and converting the data as expected based on the mappings.
    # @return [Array] Collection of hashes containing the entities obtained after processing the rows.
    #   If an error occurs while processing the error is rescued and nullable values returned for the
    #   attributes that caused the error.
    def call
      rows.map.with_index do |row, row_num|
        process_entities(row, row_num, &:call)
      end
    end

    # Iterates over the rows grouping and converting the data as expected based on the mappings.
    # @return [Array] Collection of hashes containing the entities obtained after processing the rows.
    #   If an error occurs while processing the rows an error is raised.
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
