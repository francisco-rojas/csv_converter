# frozen_string_literal: true

require 'csv'
require 'YAML'

RSpec.describe CSVConverter::FileProcessor do
  describe '#process' do
    let(:mappings_filename) { 'sales.yml' }
    let(:mappings_file_path) { file_fixture(mappings_filename) }
    let(:mappings) { YAML.load_file(mappings_file_path).deep_symbolize_keys[:mappings] }

    let(:csv_file_path) { file_fixture('sales.csv') }
    let(:csv_filename) { csv_file_path.basename.to_s }
    let(:csv_rows) { CSV.read(csv_file_path, headers: true) }
    subject { described_class.new(csv_filename, csv_rows, mappings) }
    let(:processed_file) { subject.process }
    let(:processed_row) { processed_file.first }

    it 'creates one element per row' do
      expect(processed_file.size).to eq 20
    end

    describe 'sales' do
      let(:sale) do
        {
          region: 'Middle East and North Africa',
          country: 'Libya',
          completed: 'Y',
          notes: 'LoremIpsum',
          channel: 'Offline'
        }
      end

      it 'assigns the correct data for each attribute' do
        sale.each do |attr, val|
          expect(processed_row[:sale][attr]).to eq val
        end
      end
    end

    describe 'item' do
      let(:item) do
        {
          type: 'Cosmetics',
          code: '1031422',
          description: 'Lorem ipsum'
        }
      end

      it 'assigns the correct data for each attribute' do
        item.each do |attr, val|
          expect(processed_row[:item][attr]).to eq val
        end
      end
    end

    describe 'order' do
      let(:order) do
        {
          priority: 'M',
          date: '10/18/14',
          number: '686800706',
          shipping_date: '10/31/14',
          units_sold: '8446',
          unit_price: '437.2',
          unit_cost: '263.33',
          total_revenue: '3692591.2',
          total_cost: '2224085.18',
          total_profit: '1468506.02'
        }
      end

      it 'assigns the correct data for each attribute' do
        order.each do |attr, val|
          expect(processed_row[:order][attr]).to eq val
        end
      end
    end
  end
end
