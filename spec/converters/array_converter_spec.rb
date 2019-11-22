# frozen_string_literal: true

RSpec.describe CSVConverter::Converters::ArrayConverter do
  describe 'when separator NOT provided' do
    it 'raises an error' do
      expect { described_class.new('item1, item2, item3', {}) }.to raise_error(CSVConverter::Error)
      expect { described_class.new('item1, item2, item3', separator: nil) }.to raise_error(CSVConverter::Error)
      expect { described_class.new('item1, item2, item3', nil) }.to raise_error(CSVConverter::Error)
    end
  end

  describe 'when separator provided' do
    describe '#call' do
      context 'with valid input' do
        subject { described_class.new('item 1, item 2, item 3', separator: ',') }

        it 'splits the string into an array' do
          expect(subject.call).to eq ['item 1', 'item 2', 'item 3']
        end
      end

      context 'with whitespace separator' do
        subject { described_class.new('item1 item2 item3', separator: ' ') }

        it 'splits the string into an array' do
          expect(subject.call).to eq %w[item1 item2 item3]
        end
      end

      context 'with invalid input' do
        subject { described_class.new(nil, separator: ',') }

        it 'returns the nullable object' do
          expect(subject.call).to eq []
        end
      end
    end

    describe '#call!' do
      context 'with valid input' do
        subject { described_class.new('item 1, item 2, item 3', separator: ',') }

        it 'splits the string into an array' do
          expect(subject.call!).to eq ['item 1', 'item 2', 'item 3']
        end
      end

      context 'with invalid input' do
        subject { described_class.new(nil, separator: ',') }

        it 'raises an error' do
          expect { subject.call! }.to raise_error(CSVConverter::Error)
        end
      end
    end
  end
end
