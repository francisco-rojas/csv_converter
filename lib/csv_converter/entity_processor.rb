# frozen_string_literal: true

module CSVConverter
  # Iterates over the columns of a row and processes the data accordingly
  class EntityProcessor
    attr_reader :row, :entity_mappings, :options

    def initialize(row, entity_mappings, options = {})
      @row              = row
      @entity_mappings  = entity_mappings
      @options          = options
    end

    def call
      entity_attrs(&:call)
    end

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
