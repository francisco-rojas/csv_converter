# frozen_string_literal: true

RSpec.describe CSVConverter::Converters::HashConverter do
  describe 'when item_separator NOT provided' do
    subject { described_class.new('key1: value1, key2: value2, key3: value3', key_value_separator: ':') }

    it 'raises an error' do
      expect { subject.process! }.to raise_error(ArgumentError,
                                                 'no `item_separator` provided')
    end
  end

  describe 'when key_value_separator NOT provided' do
    subject { described_class.new('key1: value1, key2: value2, key3: value3', item_separator: ',') }

    it 'raises an error' do
      expect { subject.process! }.to raise_error(ArgumentError,
                                                 'no `key_value_separator` provided')
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

      describe '#process' do
        it 'returns the nullable object' do
          expect(str1.process).to eq({})
        end
      end

      describe '#process!' do
        it 'raises an error' do
          expect { str1.process! }.to raise_error(ArgumentError)
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
          "key1" => "value1",
          "key2" => "value2",
          "key3" => "value3"
        }
      end


      describe '#process' do
        it 'splits turns the string into a hash' do
          expect(str1.process).to eq(result)
        end

        it 'strips keys and values' do
          expect(str2.process).to eq(result)
        end
      end

      describe '#process!' do
        it 'splits turns the string into a hash' do
          expect(str1.process!).to eq(result)
        end

        it 'strips keys and values' do
          expect(str2.process!).to eq(result)
        end
      end
    end
  end
end
