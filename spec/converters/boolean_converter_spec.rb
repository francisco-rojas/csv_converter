# frozen_string_literal: true

RSpec.describe CSVConverter::Converters::BooleanConverter do
  describe 'when NO truthy values provided' do
    it 'raises an error' do
      expect { described_class.new('yes', {}) }.to raise_error(CSVConverter::Error)
      expect { described_class.new('yes', truthy_values: []) }.to raise_error(CSVConverter::Error)
      expect { described_class.new('yes', nil) }.to raise_error(CSVConverter::Error)
    end
  end

  describe '#call' do
    let(:truthy_values) do
      { truthy_values: %w[YES yes Y y] }
    end

    context 'when input is in `truthy_values` list' do
      it 'returns a boolean true' do
        truthy_values[:truthy_values].each do |truthy_value|
          subject = described_class.new(truthy_value, truthy_values)
          expect(subject.call).to eq true
        end
      end
    end

    context 'when input is not in `truthy_values` list' do
      it 'returns a boolean false' do
        truthy_values[:truthy_values].each do |_truthy_value|
          subject = described_class.new('lorem', truthy_values)
          expect(subject.call).to eq false
        end
      end
    end
  end

  describe '#call!' do
    let(:truthy_values) do
      { truthy_values: %w[YES yes Y y] }
    end

    context 'when input is in `truthy_values` list' do
      it 'returns a boolean true' do
        truthy_values[:truthy_values].each do |truthy_value|
          subject = described_class.new(truthy_value, truthy_values)
          expect(subject.call!).to eq true
        end
      end
    end

    context 'when input is not in `truthy_values` list' do
      it 'returns a boolean false' do
        truthy_values[:truthy_values].each do |_truthy_value|
          subject = described_class.new('lorem', truthy_values)
          expect(subject.call!).to eq false
        end
      end
    end
  end
end
