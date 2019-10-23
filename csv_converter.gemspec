# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'csv_converter/version'

Gem::Specification.new do |spec|
  spec.name          = 'csv_converter'
  spec.version       = CSVConverter::VERSION
  spec.authors       = ['Francisco Rojas']
  spec.email         = ['josefcorojas@gmail.com']

  spec.summary       = 'This gem makes simplifies the process of adapting CSV data prior to importing it to a database.'
  spec.description   = 'This gem makes simplifies the process of adapting CSV data prior to importing it to a database.'
  spec.homepage      = 'https://github.com/francisco-rojas/csv_converter'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/francisco-rojas/csv_converter'
  spec.metadata['changelog_uri'] = 'https://github.com/francisco-rojas/csv_converter/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '~> 6.0'
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'byebug', '~> 11.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rb-readline'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.75'
end
