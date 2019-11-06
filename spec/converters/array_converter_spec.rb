# frozen_string_literal: true

RSpec.describe CSVConverter::Converters::ArrayConverter do
  describe 'when separator NOT provided' do
    it 'raises an error' do
      expect do
        described_class.new('item1, item2, item3')
      end.to raise_error(ArgumentError,
                         'no `separator` provided')
    end
  end

  describe 'when separator provided' do
    describe '#call' do
      subject { described_class.new('item1, item2, item3', separator: ',') }

      it 'splits the string into an array' do
        expect(subject.call).to eq %w[item1 item2 item3]
      end
    end

    describe '#call!' do
      subject { described_class.new('item1, item2, item3', separator: ',') }

      it 'splits the string into an array' do
        expect(subject.call!).to eq %w[item1 item2 item3]
      end
    end
  end
end
