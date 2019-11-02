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

module CSVConverter
  class Error < StandardError; end

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
end
