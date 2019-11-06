# frozen_string_literal: true

RSpec.describe CSVConverter::Converters::BooleanConverter do
  describe 'when NO truthy values provided' do
    it 'raises an error' do
      expect { described_class.new('yes') }.to raise_error(ArgumentError,
                                                           'no `truthy_values` provided')
    end
  end

  describe 'when truthy values provided' do
    let(:truthy_values) do
      { truthy_values: %w[YES yes Y y] }
    end

    it 'returns a boolean true' do
      truthy_values[:truthy_values].each do |truthy_value|
        subject = described_class.new(truthy_value, truthy_values)
        expect(subject.call).to eq true
      end
    end

    it 'returns a boolean true' do
      truthy_values[:truthy_values].each do |truthy_value|
        subject = described_class.new(truthy_value, truthy_values)
        expect(subject.call!).to eq true
      end
    end
  end
end
