# frozen_string_literal: true

module CSVConverter
  module Helpers
    def file_fixture(filename)
      spec_folder = File.dirname(File.expand_path(__dir__))
      fixtures_folder = File.join(spec_folder, 'fixtures', 'files', filename)
      Pathname.new(fixtures_folder)
    end
  end
end
