# frozen_string_literal: true

RSpec.describe CSVConverter::EntityProcessor do
  let(:entity_mappings) do
    {
      first_name: { header: 'first name', converters: { string: nil, uppercase: nil } },
      last_name: { header: 'last name', converters: { string: nil, uppercase: nil } }
    }
  end

  let(:valid_row) { CSV::Row.new(['first name', 'last name'], %i[john doe]) }
  let(:invalid_row) { CSV::Row.new(['first name', 'last name'], [nil, nil]) }

  describe '#call' do
    context 'with valid input' do
      subject { described_class.new(valid_row, entity_mappings) }

      it 'returns a hash with the entity attributes' do
        expect(subject.call).to eq(first_name: 'JOHN', last_name: 'DOE')
      end
    end

    context 'with invalid input' do
      subject { described_class.new(invalid_row, entity_mappings) }

      it 'returns a hash with the entity attributes set to the nullable object' do
        expect(subject.call).to eq(first_name: '', last_name: '')
      end
    end
  end

  describe '#call' do
    context 'with valid input' do
      subject { described_class.new(valid_row, entity_mappings) }

      it 'returns a hash with the entity attributes' do
        expect(subject.call!).to eq(first_name: 'JOHN', last_name: 'DOE')
      end
    end

    context 'with invalid input' do
      let(:options) { { filename: 'test.csv', row_num: 1, entity: :user } }
      subject { described_class.new(invalid_row, entity_mappings, options) }

      it 'raises an error' do
        expect { subject.call! }.to raise_error(CSVConverter::Error)
      end

      it 'returns the options as part of the error' do
        error = lambda do
          subject.call!
        rescue CSVConverter::Error => e
          e
        end

        expect(error.call.details).to eq(options.merge(attr: :first_name))
      end
    end
  end
end
