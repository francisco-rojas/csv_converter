# frozen_string_literal: true

module CSVConverter
  # Iterates over the columns of a row and processes the data accordingly.
  class EntityProcessor
    # The row being processed.
    # @return [Array, Hash]
    attr_reader :row

    # Entity mappings.
    # @return [Hash] configuration used to process the data.
    attr_reader :entity_mappings

    # Details of the data being processed. By default this includes:
    #   filename: the name of the file being processed.
    #   row_num: number of the row being processed.
    #   entity: the name of the entity being processed as provided in the mappings.
    #   row: the raw data of the row being processed.
    #   attr: the name of the attribute being processed as provided in the mappings.
    # Additionally it will contain all the options provided to the converter in the mappings.
    # @return [Hash]
    attr_reader :options

    # A new instance of EntityProcessor.
    # @param row (@see #row)
    # @param entity_mappings (@see #entity_mappings)
    # @param options (@see #options)
    def initialize(row, entity_mappings, options = {})
      @row              = row
      @entity_mappings  = entity_mappings
      @options          = options
    end

    # Iterates over the attributes of each entity converting the data into the format expected by the mappings.
    # @return [Hash] the attributes for each entity.
    #   If an error occurs while processing the error is rescued and nullable values returned for the
    #   attributes that caused the error.
    def call
      entity_attrs(&:call)
    end

    # Iterates over the attributes of each entity converting the data into the format expected by the mappings.
    # @return [Hash] the attributes for each entity.
    #   If an error occurs while processing the an error is raised.
    def call!
      entity_attrs(&:call!)
    end

    private

    def entity_attrs(&block)
      return nested_entity(&block) if entity_mappings[:nested]

      entity_mappings.each_with_object({}) do |(attr, attr_mappings), hash|
        processor = CSVConverter::AttributeProcessor.new(row, attr_mappings, options.merge(attr: attr))
        hash[attr] = block.call(processor)
      end
    end

    def nested_entity
      separator  = entity_mappings[:separator] || ','
      nested_row = row[entity_mappings[:header]].split(separator)
      processor = self.class.new(nested_row, entity_mappings[:mappings], options)
      yield(processor)
    end
  end
end
