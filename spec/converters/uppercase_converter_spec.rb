# frozen_string_literal: true

RSpec.describe CSVConverter::Converters::UppercaseConverter do
  describe '#call' do
    describe 'when nil input provided' do
      subject { described_class.new(nil) }

      it 'returns an empty string' do
        expect(subject.call).to eq ''
      end
    end

    describe 'when empty string provided' do
      subject { described_class.new(nil) }

      it 'returns an empty string' do
        expect(subject.call).to eq ''
      end
    end

    describe 'when data provided' do
      subject { described_class.new('lorem ') }

      it 'returns data as an uppercase string' do
        expect(subject.call).to eq 'LOREM'
      end
    end
  end

  describe '#call!' do
    describe 'when nil input provided' do
      subject { described_class.new(nil) }

      it 'raises an error' do
        expect { subject.call! }.to raise_error(CSVConverter::Error)
      end
    end

    describe 'when empty string provided' do
      subject { described_class.new(nil) }

      it 'raises an error' do
        expect { subject.call! }.to raise_error(CSVConverter::Error)
      end
    end

    describe 'when data provided' do
      subject { described_class.new('lorem ') }

      it 'returns data as an uppercase string' do
        expect(subject.call!).to eq 'LOREM'
      end
    end
  end
end
