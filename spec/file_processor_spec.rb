# frozen_string_literal: true

require 'csv'
require 'yaml'

RSpec.describe CSVConverter::FileProcessor do
  file_scenarios.each do |scenario|
    let(:csv_file_path) { file_fixture(scenario[:csv_file]) }
    let(:csv_filename) { csv_file_path.basename.to_s }
    let(:csv_rows) { CSV.read(csv_file_path, headers: scenario[:headers]) }
    subject { described_class.new(csv_filename, csv_rows, scenario[:config]) }
    let(:processed_file) { subject.call }
    let(:processed_row) { processed_file.first }

    it 'creates one element per row' do
      expect(processed_file.size).to eq 20
    end

    describe 'sales' do
      let(:sale) do
        {
          region: 'Middle East and North Africa',
          country: 'Libya',
          completed: true,
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
          date: Date.strptime('10/18/14', '%m/%d/%y'),
          number: '686800706',
          shipping_date: Date.strptime('10/31/14', '%m/%d/%y'),
          units_sold: 8446,
          unit_price: 437.2,
          unit_cost: 263.33,
          total_revenue: 3_692_591.2,
          total_cost: 2_224_085.18,
          total_profit: 1_468_506.02
        }
      end

      it 'assigns the correct data for each attribute' do
        order.each do |attr, val|
          expect(processed_row[:order][attr]).to eq val
        end
      end
    end

    describe 'company' do
      let(:company) do
        {
          company_name: 'Benton John B Jr',
          website: 'http://www.bentonjohnbjr.com',
          phone1: '504-621-8927',
          phone2: '504-845-1427',
          address: '6649 N Blue Gum St',
          city: 'New Orleans',
          county: 'Orleans',
          state: 'LA',
          zip: '70116',
          country: 'United States',
          country_code: 'US'
        }
      end

      it 'assigns the correct data for each attribute' do
        company.each do |attr, val|
          expect(processed_row[:company][attr]).to eq val
        end
      end
    end

    describe 'employee' do
      let(:employee) do
        {
          employee_id: '850297',
          name_prefix: 'Ms.',
          first_name: 'Shawna',
          middle_initial: 'W',
          last_name: 'Buck',
          gender: 'F',
          email: 'shawna.buck@gmail.com',
          date_of_birth: Date.strptime('12/12/71', '%m/%d/%y'),
          time_of_birth: '6:34:47 AM',
          age_in_yrs: 45.66,
          weight_in_kgs: 44,
          date_of_joining: Date.strptime('12/18/10', '%m/%d/%y'),
          quarter_of_joining: 'Q4',
          half_of_joining: 'H2',
          year_of_joining: 2010,
          month_of_joining: 12,
          month_name_of_joining: 'December',
          short_month: 'Dec',
          day_of_joining: 18,
          dow_of_joining: 'Saturday',
          short_dow: 'Sat',
          age_in_company: 6.61,
          salary: 119_090,
          phone_no: '702-771-7149',
          place_name: 'Las Vegas',
          county: 'Clark',
          city: 'Las Vegas',
          state: 'NV',
          zip: '89128',
          region: 'West',
          user_name: 'swbuck',
          password: 'ja8?k3BTF^]o@<&'
        }
      end

      it 'assigns the correct data for each attribute' do
        employee.each do |attr, val|
          expect(processed_row[:employee][attr]).to eq val
        end
      end
    end
  end
end
