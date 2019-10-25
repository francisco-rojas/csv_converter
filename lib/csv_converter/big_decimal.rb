# frozen_string_literal: true
require 'bigdecimal'

module CSVConverter
  # Converts a string into a decimal number
  class BigDecimal < CSVConverter::Base
    def process
      process!
    rescue ArgumentError
      nullable_object
    end

    def process!
      BigDecimal(data)
    end

    private

    def nullable_object
      0.0
    end
  end
end
