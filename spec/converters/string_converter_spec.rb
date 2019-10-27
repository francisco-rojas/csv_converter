# frozen_string_literal: true

RSpec.describe CSVConverter::Converters::StringConverter do
  describe '#process' do
    describe 'when nil input provided' do
      subject { described_class.new(nil) }

      it 'returns an empty string' do
        expect(subject.process).to eq ''
      end
    end

    describe 'when empty string provided' do
      subject { described_class.new(nil) }

      it 'returns an empty string' do
        expect(subject.process).to eq ''
      end
    end

    describe 'when data provided' do
      subject { described_class.new('lorem ') }

      it 'returns data as a string' do
        expect(subject.process).to eq 'lorem'
      end
    end
  end

  describe '#process!' do
    describe 'when nil input provided' do
      subject { described_class.new(nil) }

      it 'raises an error' do
        expect { subject.process! }.to raise_error(ArgumentError)
      end
    end

    describe 'when empty string provided' do
      subject { described_class.new(nil) }

      it 'raises an error' do
        expect { subject.process! }.to raise_error(ArgumentError)
      end
    end

    describe 'when data provided' do
      subject { described_class.new('lorem ') }

      it 'returns data as a string' do
        expect(subject.process).to eq 'lorem'
      end
    end
  end
end
