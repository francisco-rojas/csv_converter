# frozen_string_literal: true

RSpec.describe CSVConverter do
  it 'has a version number' do
    expect(CSVConverter::VERSION).not_to be nil
  end

  describe 'aliases' do
    it 'has aliases for default converters' do
      expect(CSVConverter.aliases).to eq CSVConverter::ALIASES
    end

    it 'adds a new alias' do
      CSVConverter.add_alias(:number, 'CSVConverter::Converters::IntegerConverter')
      expect(CSVConverter.aliases["number"]).to eq 'CSVConverter::Converters::IntegerConverter'
    end

    it 'adds a new aliases' do
      CSVConverter.add_aliases(
        number: 'CSVConverter::Converters::IntegerConverter',
        yes_no: 'CSVConverter::Converters::BooleanConverter'
      )
      expect(CSVConverter.aliases["number"]).to eq 'CSVConverter::Converters::IntegerConverter'
      expect(CSVConverter.aliases["yes_no"]).to eq 'CSVConverter::Converters::BooleanConverter'
    end

    it 'overrides existing alias' do
      CSVConverter.add_alias(:integer, 'CSVConverter::Converters::MyInteger')
      expect(CSVConverter.aliases["integer"]).to eq 'CSVConverter::Converters::MyInteger'
    end
  end
end
