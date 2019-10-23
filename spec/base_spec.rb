# frozen_string_literal: true

RSpec.describe CSVConverter::Base do
  class SampleConverter < CSVConverter::Base
    def process
      data
    end

    def nullable_object
      'nullable value'
    end
  end

  describe '#process' do
    describe 'when options[:empty_values] provided' do
      let(:mappings) do
        {
          options: { empty_values: %w[N/A] }
        }
      end

      context 'when data is in options[:empty_values]' do
        subject { SampleConverter.new('N/A', mappings) }

        it 'returns the nullable object' do
          expect(subject.process).to eq 'nullable value'
        end
      end

      context 'when data is nil' do
        subject { SampleConverter.new(nil, mappings) }

        it 'returns the nullable object' do
          expect(subject.process).to eq 'nullable value'
        end
      end
    end

    describe 'when no mappings provided' do
      let(:mappings) do
        {}
      end

      context 'when data is N/A' do
        subject { SampleConverter.new('N/A', mappings) }

        it 'returns the raw value' do
          expect(subject.process).to eq 'N/A'
        end
      end

      context 'when data is nil' do
        subject { SampleConverter.new(nil, mappings) }

        it 'returns the nullable object' do
          expect(subject.process).to eq 'nullable value'
        end
      end

      context 'when empty string provided' do
        subject { SampleConverter.new('', mappings) }

        it 'returns the nullable object' do
          expect(subject.process).to eq 'nullable value'
        end
      end
    end

    describe 'when options[:defaults] provided' do
      let(:mappings) do
        {
          options: { defaults: 'LoremIpsum' }
        }
      end

      context 'when nil object provided' do
        subject { SampleConverter.new(nil, mappings) }

        it 'returns the defaults' do
          expect(subject.process).to eq 'LoremIpsum'
        end
      end

      context 'when empty string provided' do
        subject { SampleConverter.new('', mappings) }

        it 'returns the defaults' do
          expect(subject.process).to eq 'LoremIpsum'
        end
      end
    end
  end
end
