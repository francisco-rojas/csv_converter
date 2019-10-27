# frozen_string_literal: true

RSpec.describe CSVConverter::Converters::FloatConverter do
  describe '#process' do
    describe 'when valid string number provided' do
      subject { described_class.new('1234.5678') }

      it 'converts the string into a float number' do
        expect(subject.process).to eq 1234.5678
      end
    end

    describe 'when invalid string provied' do
      subject { described_class.new('ABC') }

      it 'returns the nullable_object' do
        expect(subject.process).to eq nil
      end
    end
  end

  describe '#process!' do
    describe 'when valid string number provided' do
      subject { described_class.new('1234.5678') }

      it 'converts the string into a float number' do
        expect(subject.process!).to eq 1234.5678
      end
    end

    describe 'when invalid string provied' do
      subject { described_class.new('ABC') }

      it 'raises an error' do
        expect { subject.process! }.to raise_error(ArgumentError)
      end
    end
  end
end