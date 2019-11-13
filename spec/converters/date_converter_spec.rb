# frozen_string_literal: true

RSpec.describe CSVConverter::Converters::DateConverter do
  describe 'when NO date format provided' do
    it 'throws an error on initialization' do
      expect { described_class.new('10/18/14') }.to raise_error(CSVConverter::Error)
    end
  end

  describe '#call' do
    it 'returns nil when parsing date fails' do
      subject = described_class.new('101814', date_format: '%m/%d/%y')

      expect(subject.call).to eq nil
    end

    it 'returns the correct date when parsing date succeeds' do
      subject = described_class.new('10/18/14', date_format: '%m/%d/%y')

      expect(subject.call).to eq Date.strptime('10/18/14', '%m/%d/%y')
    end
  end

  describe '#call!' do
    it 'raises error when date parsing fails' do
      subject = described_class.new('101814', date_format: '%m/%d/%y')

      expect { subject.call! }.to raise_error(CSVConverter::Error)
    end

    it 'returns the correct date when parsing date succeeds' do
      subject = described_class.new('10/18/14', date_format: '%m/%d/%y')

      expect(subject.call!).to eq Date.strptime('10/18/14', '%m/%d/%y')
    end
  end
end
