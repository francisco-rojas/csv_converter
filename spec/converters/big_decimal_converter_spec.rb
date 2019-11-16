# frozen_string_literal: true

RSpec.describe CSVConverter::Converters::BigDecimalConverter do
  describe '#call' do
    context 'when period used as floating point separator' do
      subject { described_class.new('1234.5678') }

      it 'converts the string into a decimal number' do
        expect(subject.call).to eq 1234.5678
      end
    end

    context 'when comma used as floating point separator' do
      subject { described_class.new('1234,5678') }

      it 'converts the string into a decimal number' do
        expect(subject.call).to eq 1234.5678
      end
    end

    context 'when invalid input provied' do
      subject { described_class.new('ABC') }

      it 'returns the nullable_object' do
        expect(subject.call).to eq nil
      end
    end
  end

  describe '#call!' do
    context 'when period used as floating point separator' do
      subject { described_class.new('1234.5678') }

      it 'converts the string into a decimal number' do
        expect(subject.call!).to eq 1234.5678
      end
    end

    context 'when comma used as floating point separator' do
      subject { described_class.new('1234,5678') }

      it 'converts the string into a decimal number' do
        expect(subject.call!).to eq 1234.5678
      end
    end

    context 'when invalid input provied' do
      subject { described_class.new('ABC') }

      it 'raises an error' do
        expect { subject.call! }.to raise_error(CSVConverter::Error)
      end
    end
  end
end
