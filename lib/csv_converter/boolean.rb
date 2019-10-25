# frozen_string_literal: true

module CSVConverter
  # Converts a string into a boolean
  class Boolean < CSVConverter::Base
    def process
      data
    end

    private

    def nullable_object
      false
    end
  end
end
