# frozen_string_literal: true

RSpec.describe CSVConverter::Converters::BooleanConverter do
  describe '#process' do
    describe 'when truthy values provided' do
      let(:truthy_values) do
        { truthy_values: %w[YES yes Y y] }
      end

      it 'returns a boolean true' do
        truthy_values[:truthy_values].each do |truthy_value|
          subject = described_class.new(truthy_value, truthy_values)
          expect(subject.process).to eq true
        end
      end
    end

    describe 'when NO truthy values provided' do
      it 'returns the nullable object' do
        %w[TRUE true].each do |val|
          subject = described_class.new(val)
          expect(subject.process).to eq false
        end
      end
    end
  end

  describe '#process!' do
    describe 'when a truthy value provided' do
      let(:truthy_values) do
        { truthy_values: %w[YES yes Y y] }
      end

      it 'returns a boolean true' do
        truthy_values[:truthy_values].each do |truthy_value|
          subject = described_class.new(truthy_value, truthy_values)
          expect(subject.process!).to eq true
        end
      end
    end

    describe 'when NO truthy values provided' do
      it 'raises an error' do
        %w[TRUE true].each do |truthy_value|
          subject = described_class.new(truthy_value)
          expect { subject.process! }.to raise_error(CSVConverter::Error,
                                                     'no truthy values list provided to cast the provided data')
        end
      end
    end
  end
end
