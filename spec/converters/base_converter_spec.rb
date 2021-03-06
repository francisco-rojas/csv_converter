# frozen_string_literal: true

RSpec.describe CSVConverter::Converters::BaseConverter do
  class SampleConverter < described_class
    def call
      data
    end

    def nullable_object
      'nullable value'
    end
  end

  describe '#call' do
    describe 'when options[:empty_values] provided' do
      let(:options) do
        { empty_values: %w[N/A] }
      end

      context 'when data is in options[:empty_values]' do
        subject { SampleConverter.new('N/A', options) }

        it 'returns the nullable object' do
          expect(subject.call).to eq 'nullable value'
        end
      end

      context 'when data is nil' do
        subject { SampleConverter.new(nil, options) }

        it 'returns the nullable object' do
          expect(subject.call).to eq 'nullable value'
        end
      end
    end

    describe 'when no options provided' do
      let(:options) do
        {}
      end

      context 'when data is N/A' do
        subject { SampleConverter.new('N/A', options) }

        it 'returns the raw value' do
          expect(subject.call).to eq 'N/A'
        end
      end

      context 'when data is nil' do
        subject { SampleConverter.new(nil, options) }

        it 'returns the nullable object' do
          expect(subject.call).to eq 'nullable value'
        end
      end

      context 'when empty string provided' do
        subject { SampleConverter.new('', options) }

        it 'returns the nullable object' do
          expect(subject.call).to eq 'nullable value'
        end
      end
    end

    describe 'when options[:default] provided' do
      let(:options) do
        { default: 'LoremIpsum' }
      end

      context 'when nil object provided' do
        subject { SampleConverter.new(nil, options) }

        it 'returns the default' do
          expect(subject.call).to eq 'LoremIpsum'
        end
      end

      context 'when empty string provided' do
        subject { SampleConverter.new('', options) }

        it 'returns the default' do
          expect(subject.call).to eq 'LoremIpsum'
        end
      end
    end
  end
end
