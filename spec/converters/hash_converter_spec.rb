# frozen_string_literal: true

RSpec.describe CSVConverter::Converters::HashConverter do
  describe 'when item_separator NOT provided' do
    subject { described_class.new('key1: value1, key2: value2, key3: value3', key_value_separator: ':') }

    it 'raises an error' do
      expect { subject.call! }.to raise_error(CSVConverter::Error)
    end
  end

  describe 'when key_value_separator NOT provided' do
    subject { described_class.new('key1: value1, key2: value2, key3: value3', item_separator: ',') }

    it 'raises an error' do
      expect { subject.call! }.to raise_error(CSVConverter::Error)
    end
  end

  describe 'data processing' do
    describe 'when string cannot be converted to hash' do
      let(:str1) do
        described_class.new(
          'invalid',
          item_separator: ',',
          key_value_separator: ':'
        )
      end

      describe '#call' do
        it 'returns the nullable object' do
          expect(str1.call).to eq({})
        end
      end

      describe '#call!' do
        it 'raises an error' do
          expect { str1.call! }.to raise_error(CSVConverter::Error)
        end
      end
    end

    describe 'when string can be converted to hash' do
      let(:str1) do
        described_class.new(
          'key1 value1, key2 value2, key3 value3',
          item_separator: ',',
          key_value_separator: ' '
        )
      end

      let(:str2) do
        described_class.new(
          'key1: value1 , key2: value2 , key3: value3 ',
          item_separator: ',',
          key_value_separator: ':'
        )
      end

      let(:result) do
        {
          'key1' => 'value1',
          'key2' => 'value2',
          'key3' => 'value3'
        }
      end

      describe '#call' do
        it 'splits turns the string into a hash' do
          expect(str1.call).to eq(result)
        end

        it 'strips keys and values' do
          expect(str2.call).to eq(result)
        end
      end

      describe '#call!' do
        it 'splits turns the string into a hash' do
          expect(str1.call!).to eq(result)
        end

        it 'strips keys and values' do
          expect(str2.call!).to eq(result)
        end
      end
    end
  end
end
