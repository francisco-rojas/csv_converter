# frozen_string_literal: true

require 'date'

require 'active_support'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/inflector'

require 'csv_converter/version'
require 'csv_converter/converters/base_converter'
require 'csv_converter/converters/array_converter'
require 'csv_converter/converters/hash_converter'
require 'csv_converter/converters/big_decimal_converter'
require 'csv_converter/converters/boolean_converter'
require 'csv_converter/converters/date_converter'
require 'csv_converter/converters/float_converter'
require 'csv_converter/converters/integer_converter'
require 'csv_converter/converters/string_converter'
require 'csv_converter/converters/uppercase_converter'
require 'csv_converter/converters/lowercase_converter'
require 'csv_converter/file_processor'
require 'csv_converter/entity_processor'
require 'csv_converter/attribute_processor'

# CSVConverter groups and transforms tabulated data contained in files such as csv or spreadsheets.
module CSVConverter
  # Error holds error messages as well as details of the data being processed.
  class Error < StandardError
    # Details of the data being processed when the error happened. By default this includes:
    #   filename: the name of the file being processed
    #   row_num: number of the row being processed
    #   entity: the name of the entity being processed as provided in the mappings
    #   row: the raw data of the row being processed
    #   attr: the name of the attribute being processed as provided in the mappings
    # Additionally it contains all the options provided to the converter in the mappings.
    # @return [Hash]
    attr_reader :details

    # A new instance of Error.
    # @param message [String] the error description
    # @param details [Hash] info about the data being proccesed at the time of the error
    def initialize(message, details = {})
      @details = details
      super("#{message} on: #{details}")
    end
  end

  ALIASES = {
    array: 'CSVConverter::Converters::ArrayConverter',
    boolean: 'CSVConverter::Converters::BooleanConverter',
    date: 'CSVConverter::Converters::DateConverter',
    decimal: 'CSVConverter::Converters::BigDecimalConverter',
    float: 'CSVConverter::Converters::FloatConverter',
    hash: 'CSVConverter::Converters::HashConverter',
    integer: 'CSVConverter::Converters::IntegerConverter',
    lowercase: 'CSVConverter::Converters::LowercaseConverter',
    string: 'CSVConverter::Converters::StringConverter',
    uppercase: 'CSVConverter::Converters::UppercaseConverter'
  }.with_indifferent_access

  # When no custom aliases are included it returns CSVConverter::ALIASES.
  # When custom converter alises are included it returns the whole list of aliases.
  # @return [Hash] list of aliases for each converter class.
  def self.aliases
    @aliases || ALIASES
  end

  # Adds an alias to the list of aliases
  # @param new_alias [Symbol, String] the name of the alias
  # @param klass [Symbol, String] class name of the converter
  # @return (@see #aliases)
  def self.add_alias(new_alias, klass)
    @aliases = aliases.merge(new_alias.to_sym => klass.to_s)
  end

  # Adds one or more alieases to the list of aliases
  # @param new_aliases [Hash] list of aliases to append to the list,
  #   where the key is the name of the alias and the value is the class name of the converter
  # @return (@see #aliases)
  def self.add_aliases(new_aliases)
    @aliases = aliases.merge(new_aliases)
  end
end
