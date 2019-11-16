# frozen_string_literal: true

require 'csv'

RSpec.describe CSVConverter::AttributeProcessor do
  let(:attr_mappings) do
    {
      header: 'first name',
      converters: { string: nil, uppercase: nil }
    }
  end

  let(:valid_row) { CSV::Row.new(['first name', 'last name'], %i[john doe]) }
  let(:invalid_row) { CSV::Row.new(['first name', 'last name'], [nil, nil]) }

  describe '#call' do
    context 'with valid input' do
      subject { described_class.new(valid_row, attr_mappings) }

      it 'returns the processed data' do
        expect(subject.call).to eq 'JOHN'
      end
    end

    context 'with invalid input' do
      subject { described_class.new(invalid_row, attr_mappings) }

      it 'returns the nullable object' do
        expect(subject.call).to eq ''
      end
    end
  end

  describe '#call!' do
    context 'with valid input' do
      subject { described_class.new(valid_row, attr_mappings) }

      it 'returns the processed data' do
        expect(subject.call!).to eq 'JOHN'
      end
    end

    context 'with invalid input' do
      let(:options) { { filename: 'test.csv', row_num: 1, entity: :user } }
      subject { described_class.new(invalid_row, attr_mappings, options) }

      it 'raises an error' do
        expect { subject.call! }.to raise_error(CSVConverter::Error)
      end

      it 'returns the options as part of the error' do
        error = lambda do
          subject.call!
        rescue CSVConverter::Error => e
          e
        end

        expect(error.call.details).to eq(options)
      end
    end
  end
end
