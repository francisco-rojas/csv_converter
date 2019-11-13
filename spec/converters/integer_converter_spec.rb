# frozen_string_literal: true

RSpec.describe CSVConverter::Converters::IntegerConverter do
  describe '#call' do
    describe 'when valid string number provided' do
      subject { described_class.new('1234') }

      it 'converts the string into a integer number' do
        expect(subject.call).to eq 1234
      end
    end

    describe 'when invalid string provied' do
      subject { described_class.new('ABC') }

      it 'returns the nullable_object' do
        expect(subject.call).to eq nil
      end
    end
  end

  describe '#call!' do
    describe 'when valid string number provided' do
      subject { described_class.new('1234') }

      it 'converts the string into a integer number' do
        expect(subject.call!).to eq 1234
      end
    end

    describe 'when invalid string provied' do
      subject { described_class.new('ABC') }

      it 'raises an error' do
        expect { subject.call! }.to raise_error(CSVConverter::Error)
      end
    end
  end
end
