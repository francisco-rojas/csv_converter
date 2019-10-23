# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/inflector'

require 'csv_converter/version'
require 'csv_converter/base'
require 'csv_converter/array'
require 'csv_converter/big_decimal'
require 'csv_converter/boolean'
require 'csv_converter/date'
require 'csv_converter/float'
require 'csv_converter/integer'
require 'csv_converter/string'
require 'csv_converter/uppercase'
require 'csv_converter/file_processor'

module CSVConverter
  class Error < StandardError; end
  # Your code goes here...
end
