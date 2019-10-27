# frozen_string_literal: true

RSpec.describe CSVConverter::Converters::DateConverter do
  describe 'when NO date format provided' do
    it 'throws an error on initialization' do
      expect { described_class.new('10/18/14') }.to raise_error(ArgumentError, 'You must specify a `date_format`')
    end
  end

  describe '#process' do
    it 'returns nil when parsing date fails' do
      subject = described_class.new('101814', date_format: '%m/%d/%y')

      expect(subject.process).to eq nil
    end

    it 'returns the correct date when parsing date succeeds' do
      subject = described_class.new('10/18/14', date_format: '%m/%d/%y')

      expect(subject.process).to eq Date.strptime('10/18/14', '%m/%d/%y')
    end
  end

  describe '#process!' do
    it 'raises error when date parsing fails' do
      subject = described_class.new('101814', date_format: '%m/%d/%y')

      expect { subject.process! }.to raise_error(ArgumentError, 'invalid date')
    end

    it 'returns the correct date when parsing date succeeds' do
      subject = described_class.new('10/18/14', date_format: '%m/%d/%y')

      expect(subject.process!).to eq Date.strptime('10/18/14', '%m/%d/%y')
    end
  end
end
