# frozen_string_literal: true

module CSVConverter
  # Cleans up a string
  class String < CSVConverter::Base
    def process
      data
    end

    private

    def nullable_object
      ''
    end
  end
end
