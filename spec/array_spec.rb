# frozen_string_literal: true

RSpec.describe CSVConverter::Array do
  describe '#process' do
    describe 'when separator provided' do
      subject { described_class.new('item1, item2, item3', separator: ',') }

      it 'splits the string into an array' do
        expect(subject.process).to eq %w[item1 item2 item3]
      end
    end

    describe 'when separator NOT provided' do
      subject { described_class.new('item1, item2, item3') }

      it 'wraps the data in an array' do
        expect(subject.process).to eq ['item1, item2, item3']
      end
    end
  end

  describe '#process!' do
    describe 'when separator provided' do
      subject { described_class.new('item1, item2, item3', separator: ',') }

      it 'splits the string into an array' do
        expect(subject.process!).to eq %w[item1 item2 item3]
      end
    end

    describe 'when separator NOT provided' do
      subject { described_class.new('item1, item2, item3') }

      it 'raises an error' do
        expect { subject.process! }.to raise_error(CSVConverter::Error,
          'a `separator` must be provided in order to split the string')
      end
    end
  end
end
