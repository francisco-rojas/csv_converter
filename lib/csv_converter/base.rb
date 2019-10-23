# frozen_string_literal: true

module CSVConverter
  # Defines the interface that all converters must implement
  class Base
    attr_reader :data, :options

    def initialize(data, options = {})
      @data     = data.to_s.strip
      @options  = options
    end

    def process
      raise NotImplementedError
    end

    private

    def nullable_object
      raise NotImplementedError
    end
  end
end
