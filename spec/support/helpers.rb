# frozen_string_literal: true

module CSVConverter
  module Helpers
    def file_fixture(filename)
      spec_folder = File.dirname(File.expand_path(__dir__))
      fixtures_folder = File.join(spec_folder, 'fixtures', 'files', filename)
      Pathname.new(fixtures_folder)
    end

    def load_yml(filename)
      path = file_fixture(filename)
      YAML.load_file(path).deep_symbolize_keys[:config]
    end

    def file_scenarios
      [
        {
          csv_file: 'sales_with_headers.csv',
          config: load_yml('sales_mappings_with_headers_and_converters_names.yml'),
          headers: true
        },
        {
          csv_file: 'sales_with_headers.csv',
          config: load_yml('sales_mappings_with_headers_and_converters_aliases.yml'),
          headers: true
        },
        {
          csv_file: 'sales_with_headers.csv',
          config: sales_mappings_with_headers[:mappings],
          headers: true
        },
        {
          csv_file: 'sales_without_headers.csv',
          config: load_yml('sales_mappings_without_headers_and_converters_names.yml'),
          headers: false
        },
        {
          csv_file: 'sales_without_headers.csv',
          config: load_yml('sales_mappings_without_headers_and_converters_aliases.yml'),
          headers: false
        },
        {
          csv_file: 'sales_without_headers.csv',
          config: sales_mappings_without_headers[:mappings],
          headers: false
        }
      ]
    end

    def sales_mappings_with_headers
      {
        mappings: {
          sale: {
            region: {
              header: 'Sales Region',
              converters: {
                proc { |raw_data, _options| raw_data.to_s } => nil
              }
            },
            country: {
              header: 'Sales Country',
              converters: {
                'CSVConverter::Converters::StringConverter' => nil
              }
            },
            completed: {
              header: 'Sale Completed',
              converters: {
                ->(raw_data, _) { %w[Yes YES Y y].include?(raw_data) } => nil
              }
            },
            notes: {
              header: 'Sale Notes',
              converters: {
                lambda do |raw_data, options|
                  options[:empty_values].include?(raw_data) ? '' : raw_data
                end => {
                  empty_values: ['NA', 'na', 'N/A', 'n/a']
                }
              }
            },
            channel: {
              header: 'Sale Channel',
              converters: {
                'CSVConverter::Converters::StringConverter' => nil
              }
            }
          },
          item: {
            type: {
              header: 'Item Type',
              converters: {
                'CSVConverter::Converters::StringConverter' => {
                  default: 'Article'
                }
              }
            },
            code: {
              header: 'Item Code',
              converters: {
                'CSVConverter::Converters::StringConverter' => nil
              }
            },
            description: {
              header: 'Item Description',
              converters: {
                'CSVConverter::Converters::StringConverter' => nil
              }
            }
          },
          order: {
            priority: {
              header: 'Order Priority',
              converters: {
                'CSVConverter::Converters::StringConverter' => nil,
                'CSVConverter::Converters::UppercaseConverter' => nil
              }
            },
            date: {
              header: 'Order Date (mm/dd/yy)',
              converters: {
                "CSVConverter::Converters::DateConverter": {
                  date_format: '%m/%d/%y'
                }
              }
            },
            number: {
              header: 'Order #',
              converters: {
                'CSVConverter::Converters::StringConverter' => nil
              }
            },
            shipping_date: {
              header: 'Order Ship Date',
              converters: {
                'CSVConverter::Converters::DateConverter' => {
                  date_format: '%m/%d/%y'
                }
              }
            },
            units_sold: {
              header: 'Order Units Sold',
              converters: {
                'CSVConverter::Converters::IntegerConverter' => nil
              }
            },
            unit_price: {
              header: 'Order Unit Price',
              converters: {
                'CSVConverter::Converters::BigDecimalConverter' => nil
              }
            },
            unit_cost: {
              header: 'Order Unit Cost',
              converters: {
                'CSVConverter::Converters::BigDecimalConverter' => nil
              }
            },
            total_revenue: {
              header: 'Total Revenue',
              converters: {
                'CSVConverter::Converters::BigDecimalConverter' => nil
              }
            },
            total_cost: {
              header: 'Total Cost',
              converters: {
                'CSVConverter::Converters::BigDecimalConverter' => nil
              }
            },
            total_profit: {
              header: 'Total Profit',
              converters: {
                'CSVConverter::Converters::BigDecimalConverter' => nil
              }
            }
          },
          company: {
            nested: true,
            header: 'Company',
            mappings: {
              company_name: {
                header: 0,
                converters: {
                  string: nil
                }
              },
              website: {
                header: 1,
                converters: {
                  string: nil
                }
              },
              phone1: {
                header: 2,
                converters: {
                  string: nil
                }
              },
              phone2: {
                header: 3,
                converters: {
                  string: nil
                }
              },
              address: {
                header: 4,
                converters: {
                  string: nil
                }
              },
              city: {
                header: 5,
                converters: {
                  string: nil
                }
              },
              county: {
                header: 6,
                converters: {
                  string: nil
                }
              },
              state: {
                header: 7,
                converters: {
                  string: nil,
                  uppercase: nil
                }
              },
              zip: {
                header: 8,
                converters: {
                  string: nil
                }
              },
              country: {
                header: 9,
                converters: {
                  string: nil
                }
              },
              country_code: {
                header: 10,
                converters: {
                  string: nil,
                  uppercase: nil
                }
              }
            }
          },
          employee: {
            nested: true,
            header: 'Employee',
            mappings: {
              employee_id: {
                header: 0,
                converters: {
                  string: nil
                }
              },
              name_prefix: {
                header: 1,
                converters: {
                  string: nil
                }
              },
              first_name: {
                header: 2,
                converters: {
                  string: nil
                }
              },
              middle_initial: {
                header: 3,
                converters: {
                  string: nil,
                  uppercase: nil
                }
              },
              last_name: {
                header: 4,
                converters: {
                  string: nil
                }
              },
              gender: {
                header: 5,
                converters: {
                  string: nil
                }
              },
              email: {
                header: 6,
                converters: {
                  string: nil
                }
              },
              date_of_birth: {
                header: 7,
                converters: {
                  date: {
                    date_format: '%m/%d/%y'
                  }
                }
              },
              time_of_birth: {
                header: 8,
                converters: {
                  string: nil
                }
              },
              age_in_yrs: {
                header: 9,
                converters: {
                  float: nil
                }
              },
              weight_in_kgs: {
                header: 10,
                converters: {
                  integer: nil
                }
              },
              date_of_joining: {
                header: 11,
                converters: {
                  date: {
                    date_format: '%m/%d/%y'
                  }
                }
              },
              quarter_of_joining: {
                header: 12,
                converters: {
                  string: nil,
                  uppercase: nil
                }
              },
              half_of_joining: {
                header: 13,
                converters: {
                  string: nil,
                  uppercase: nil
                }
              },
              year_of_joining: {
                header: 14,
                converters: {
                  integer: nil
                }
              },
              month_of_joining: {
                header: 15,
                converters: {
                  integer: nil
                }
              },
              month_name_of_joining: {
                header: 16,
                converters: {
                  string: nil
                }
              },
              short_month: {
                header: 17,
                converters: {
                  string: nil
                }
              },
              day_of_joining: {
                header: 18,
                converters: {
                  integer: nil
                }
              },
              dow_of_joining: {
                header: 19,
                converters: {
                  string: nil
                }
              },
              short_dow: {
                header: 20,
                converters: {
                  string: nil
                }
              },
              age_in_company: {
                header: 21,
                converters: {
                  float: nil
                }
              },
              salary: {
                header: 22,
                converters: {
                  integer: nil
                }
              },
              phone_no: {
                header: 23,
                converters: {
                  string: nil
                }
              },
              place_name: {
                header: 24,
                converters: {
                  string: nil
                }
              },
              county: {
                header: 25,
                converters: {
                  string: nil
                }
              },
              city: {
                header: 26,
                converters: {
                  string: nil
                }
              },
              state: {
                header: 27,
                converters: {
                  string: nil,
                  uppercase: nil
                }
              },
              zip: {
                header: 28,
                converters: {
                  string: nil
                }
              },
              region: {
                header: 29,
                converters: {
                  string: nil
                }
              },
              user_name: {
                header: 30,
                converters: {
                  string: nil
                }
              },
              password: {
                header: 31,
                converters: {
                  string: nil
                }
              }
            }
          }
        }
      }
    end

    def sales_mappings_without_headers
      {
        mappings: {
          sale: {
            region: {
              header: 0,
              converters: {
                'CSVConverter::Converters::StringConverter' => nil
              }
            },
            country: {
              header: 1,
              converters: {
                'CSVConverter::Converters::StringConverter' => nil
              }
            },
            completed: {
              header: 2,
              converters: {
                'CSVConverter::Converters::BooleanConverter' => {
                  truthy_values: %w[Yes YES Y y]
                }
              }
            },
            notes: {
              header: 3,
              converters: {
                'CSVConverter::Converters::StringConverter' => {
                  empty_values: ['NA', 'na', 'N/A', 'n/a']
                }
              }
            },
            channel: {
              header: 7,
              converters: {
                'CSVConverter::Converters::StringConverter' => nil
              }
            }
          },
          item: {
            type: {
              header: 4,
              converters: {
                'CSVConverter::Converters::StringConverter' => {
                  default: 'Article'
                }
              }
            },
            code: {
              header: 5,
              converters: {
                'CSVConverter::Converters::StringConverter' => nil
              }
            },
            description: {
              header: 6,
              converters: {
                'CSVConverter::Converters::StringConverter' => nil
              }
            }
          },
          order: {
            priority: {
              header: 8,
              converters: {
                'CSVConverter::Converters::StringConverter' => nil,
                'CSVConverter::Converters::UppercaseConverter' => nil
              }
            },
            date: {
              header: 9,
              converters: {
                "CSVConverter::Converters::DateConverter": {
                  date_format: '%m/%d/%y'
                }
              }
            },
            number: {
              header: 10,
              converters: {
                'CSVConverter::Converters::StringConverter' => nil
              }
            },
            shipping_date: {
              header: 11,
              converters: {
                'CSVConverter::Converters::DateConverter' => {
                  date_format: '%m/%d/%y'
                }
              }
            },
            units_sold: {
              header: 12,
              converters: {
                'CSVConverter::Converters::IntegerConverter' => nil
              }
            },
            unit_price: {
              header: 13,
              converters: {
                'CSVConverter::Converters::BigDecimalConverter' => nil
              }
            },
            unit_cost: {
              header: 14,
              converters: {
                'CSVConverter::Converters::BigDecimalConverter' => nil
              }
            },
            total_revenue: {
              header: 15,
              converters: {
                'CSVConverter::Converters::BigDecimalConverter' => nil
              }
            },
            total_cost: {
              header: 16,
              converters: {
                'CSVConverter::Converters::BigDecimalConverter' => nil
              }
            },
            total_profit: {
              header: 17,
              converters: {
                'CSVConverter::Converters::BigDecimalConverter' => nil
              }
            }
          },
          company: {
            nested: true,
            header: 18,
            mappings: {
              company_name: {
                header: 0,
                converters: {
                  string: nil
                }
              },
              website: {
                header: 1,
                converters: {
                  string: nil
                }
              },
              phone1: {
                header: 2,
                converters: {
                  string: nil
                }
              },
              phone2: {
                header: 3,
                converters: {
                  string: nil
                }
              },
              address: {
                header: 4,
                converters: {
                  string: nil
                }
              },
              city: {
                header: 5,
                converters: {
                  string: nil
                }
              },
              county: {
                header: 6,
                converters: {
                  string: nil
                }
              },
              state: {
                header: 7,
                converters: {
                  string: nil,
                  uppercase: nil
                }
              },
              zip: {
                header: 8,
                converters: {
                  string: nil
                }
              },
              country: {
                header: 9,
                converters: {
                  string: nil
                }
              },
              country_code: {
                header: 10,
                converters: {
                  string: nil,
                  uppercase: nil
                }
              }
            }
          },
          employee: {
            nested: true,
            header: 19,
            mappings: {
              employee_id: {
                header: 0,
                converters: {
                  string: nil
                }
              },
              name_prefix: {
                header: 1,
                converters: {
                  string: nil
                }
              },
              first_name: {
                header: 2,
                converters: {
                  string: nil
                }
              },
              middle_initial: {
                header: 3,
                converters: {
                  string: nil,
                  uppercase: nil
                }
              },
              last_name: {
                header: 4,
                converters: {
                  string: nil
                }
              },
              gender: {
                header: 5,
                converters: {
                  string: nil
                }
              },
              email: {
                header: 6,
                converters: {
                  string: nil
                }
              },
              date_of_birth: {
                header: 7,
                converters: {
                  date: {
                    date_format: '%m/%d/%y'
                  }
                }
              },
              time_of_birth: {
                header: 8,
                converters: {
                  string: nil
                }
              },
              age_in_yrs: {
                header: 9,
                converters: {
                  float: nil
                }
              },
              weight_in_kgs: {
                header: 10,
                converters: {
                  integer: nil
                }
              },
              date_of_joining: {
                header: 11,
                converters: {
                  date: {
                    date_format: '%m/%d/%y'
                  }
                }
              },
              quarter_of_joining: {
                header: 12,
                converters: {
                  string: nil,
                  uppercase: nil
                }
              },
              half_of_joining: {
                header: 13,
                converters: {
                  string: nil,
                  uppercase: nil
                }
              },
              year_of_joining: {
                header: 14,
                converters: {
                  integer: nil
                }
              },
              month_of_joining: {
                header: 15,
                converters: {
                  integer: nil
                }
              },
              month_name_of_joining: {
                header: 16,
                converters: {
                  string: nil
                }
              },
              short_month: {
                header: 17,
                converters: {
                  string: nil
                }
              },
              day_of_joining: {
                header: 18,
                converters: {
                  integer: nil
                }
              },
              dow_of_joining: {
                header: 19,
                converters: {
                  string: nil
                }
              },
              short_dow: {
                header: 20,
                converters: {
                  string: nil
                }
              },
              age_in_company: {
                header: 21,
                converters: {
                  float: nil
                }
              },
              salary: {
                header: 22,
                converters: {
                  integer: nil
                }
              },
              phone_no: {
                header: 23,
                converters: {
                  string: nil
                }
              },
              place_name: {
                header: 24,
                converters: {
                  string: nil
                }
              },
              county: {
                header: 25,
                converters: {
                  string: nil
                }
              },
              city: {
                header: 26,
                converters: {
                  string: nil
                }
              },
              state: {
                header: 27,
                converters: {
                  string: nil,
                  uppercase: nil
                }
              },
              zip: {
                header: 28,
                converters: {
                  string: nil
                }
              },
              region: {
                header: 29,
                converters: {
                  string: nil
                }
              },
              user_name: {
                header: 30,
                converters: {
                  string: nil
                }
              },
              password: {
                header: 31,
                converters: {
                  string: nil
                }
              }
            }
          }
        }
      }
    end
  end
end
