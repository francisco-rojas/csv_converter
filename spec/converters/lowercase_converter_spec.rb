# frozen_string_literal: true

RSpec.describe CSVConverter::Converters::LowercaseConverter do
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
      subject { described_class.new('LOREM ') }

      it 'returns data as an uppercase string' do
        expect(subject.call).to eq 'lorem'
      end
    end
  end

  describe '#call!' do
    describe 'when nil input provided' do
      subject { described_class.new(nil) }

      it 'raises an error' do
        expect { subject.call! }.to raise_error(ArgumentError)
      end
    end

    describe 'when empty string provided' do
      subject { described_class.new(nil) }

      it 'raises an error' do
        expect { subject.call! }.to raise_error(ArgumentError)
      end
    end

    describe 'when data provided' do
      subject { described_class.new('LOREM ') }

      it 'returns data as a lowercase string' do
        expect(subject.call!).to eq 'lorem'
      end
    end
  end
end
