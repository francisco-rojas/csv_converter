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
              header: "Sales Region",
              converters: {
                "CSVConverter::Converters::StringConverter" => nil
              }
            },
            country: {
              header: "Sales Country",
              converters: {
                "CSVConverter::Converters::StringConverter" => nil
              }
            },
            completed: {
              header: "Sale Completed",
              converters: {
                "CSVConverter::Converters::BooleanConverter" => {
                  truthy_values: ["Yes", "YES", "Y", "y"]
                }
              }
            },
            notes: {
              header: "Sale Notes",
              converters: {
                "CSVConverter::Converters::StringConverter" => {
                  empty_values: ["NA", "na", "N/A", "n/a"]
                }
              }
            },
            channel: {
              header: "Sale Channel",
              converters: {
                "CSVConverter::Converters::StringConverter" => nil
              }
            }
          },
          item: {
            type: {
              header: "Item Type",
              converters: {
                "CSVConverter::Converters::StringConverter" => {
                  default: "Article"
                }
              }
            },
            code: {
              header: "Item Code",
              converters: {
                "CSVConverter::Converters::StringConverter" => nil
              }
            },
            description: {
              header: "Item Description",
              converters: {
                "CSVConverter::Converters::StringConverter" => nil
              }
            }
          },
          order: {
            priority: {
              header: "Order Priority",
              converters: {
                "CSVConverter::Converters::StringConverter" => nil,
                "CSVConverter::Converters::UppercaseConverter" => nil
              }
            },
            date: {
              header: "Order Date (mm/dd/yy)",
              converters: {
                "CSVConverter::Converters::DateConverter": {
                  date_format: "%m/%d/%y"
                }
              }
            },
            number: {
              header: "Order #",
              converters: {
                "CSVConverter::Converters::StringConverter" => nil
              }
            },
            shipping_date: {
              header: "Order Ship Date",
              converters: {
                "CSVConverter::Converters::DateConverter" => {
                  date_format: "%m/%d/%y"
                }
              }
            },
            units_sold: {
              header: "Order Units Sold",
              converters: {
                "CSVConverter::Converters::IntegerConverter" => nil
              }
            },
            unit_price: {
              header: "Order Unit Price",
              converters: {
                "CSVConverter::Converters::BigDecimalConverter" => nil
              }
            },
            unit_cost: {
              header: "Order Unit Cost",
              converters: {
                "CSVConverter::Converters::BigDecimalConverter" => nil
              }
            },
            total_revenue: {
              header: "Total Revenue",
              converters: {
                "CSVConverter::Converters::BigDecimalConverter" => nil
              }
            },
            total_cost: {
              header: "Total Cost",
              converters: {
                "CSVConverter::Converters::BigDecimalConverter" => nil
              }
            },
            total_profit: {
              header: "Total Profit",
              converters: {
                "CSVConverter::Converters::BigDecimalConverter" => nil
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
                "CSVConverter::Converters::StringConverter" => nil
              }
            },
            country: {
              header: 1,
              converters: {
                "CSVConverter::Converters::StringConverter" => nil
              }
            },
            completed: {
              header: 2,
              converters: {
                "CSVConverter::Converters::BooleanConverter" => {
                  truthy_values: ["Yes", "YES", "Y", "y"]
                }
              }
            },
            notes: {
              header: 3,
              converters: {
                "CSVConverter::Converters::StringConverter" => {
                  empty_values: ["NA", "na", "N/A", "n/a"]
                }
              }
            },
            channel: {
              header: 7,
              converters: {
                "CSVConverter::Converters::StringConverter" => nil
              }
            }
          },
          item: {
            type: {
              header: 4,
              converters: {
                "CSVConverter::Converters::StringConverter" => {
                  default: "Article"
                }
              }
            },
            code: {
              header: 5,
              converters: {
                "CSVConverter::Converters::StringConverter" => nil
              }
            },
            description: {
              header: 6,
              converters: {
                "CSVConverter::Converters::StringConverter" => nil
              }
            }
          },
          order: {
            priority: {
              header: 8,
              converters: {
                "CSVConverter::Converters::StringConverter" => nil,
                "CSVConverter::Converters::UppercaseConverter" => nil
              }
            },
            date: {
              header: 9,
              converters: {
                "CSVConverter::Converters::DateConverter": {
                  date_format: "%m/%d/%y"
                }
              }
            },
            number: {
              header: 10,
              converters: {
                "CSVConverter::Converters::StringConverter" => nil
              }
            },
            shipping_date: {
              header: 11,
              converters: {
                "CSVConverter::Converters::DateConverter" => {
                  date_format: "%m/%d/%y"
                }
              }
            },
            units_sold: {
              header: 12,
              converters: {
                "CSVConverter::Converters::IntegerConverter" => nil
              }
            },
            unit_price: {
              header: 13,
              converters: {
                "CSVConverter::Converters::BigDecimalConverter" => nil
              }
            },
            unit_cost: {
              header: 14,
              converters: {
                "CSVConverter::Converters::BigDecimalConverter" => nil
              }
            },
            total_revenue: {
              header: 15,
              converters: {
                "CSVConverter::Converters::BigDecimalConverter" => nil
              }
            },
            total_cost: {
              header: 16,
              converters: {
                "CSVConverter::Converters::BigDecimalConverter" => nil
              }
            },
            total_profit: {
              header: 17,
              converters: {
                "CSVConverter::Converters::BigDecimalConverter" => nil
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
                "CSVConverter::Converters::StringConverter" => nil
              }
            },
            country: {
              header: 1,
              converters: {
                "CSVConverter::Converters::StringConverter" => nil
              }
            },
            completed: {
              header: 2,
              converters: {
                "CSVConverter::Converters::BooleanConverter" => {
                  truthy_values: ["Yes", "YES", "Y", "y"]
                }
              }
            },
            notes: {
              header: 3,
              converters: {
                "CSVConverter::Converters::StringConverter" => {
                  empty_values: ["NA", "na", "N/A", "n/a"]
                }
              }
            },
            channel: {
              header: 7,
              converters: {
                "CSVConverter::Converters::StringConverter" => nil
              }
            }
          },
          item: {
            type: {
              header: 4,
              converters: {
                "CSVConverter::Converters::StringConverter" => {
                  default: "Article"
                }
              }
            },
            code: {
              header: 5,
              converters: {
                "CSVConverter::Converters::StringConverter" => nil
              }
            },
            description: {
              header: 6,
              converters: {
                "CSVConverter::Converters::StringConverter" => nil
              }
            }
          },
          order: {
            priority: {
              header: 8,
              converters: {
                "CSVConverter::Converters::StringConverter" => nil,
                "CSVConverter::Converters::UppercaseConverter" => nil
              }
            },
            date: {
              header: 9,
              converters: {
                "CSVConverter::Converters::DateConverter": {
                  date_format: "%m/%d/%y"
                }
              }
            },
            number: {
              header: 10,
              converters: {
                "CSVConverter::Converters::StringConverter" => nil
              }
            },
            shipping_date: {
              header: 11,
              converters: {
                "CSVConverter::Converters::DateConverter" => {
                  date_format: "%m/%d/%y"
                }
              }
            },
            units_sold: {
              header: 12,
              converters: {
                "CSVConverter::Converters::IntegerConverter" => nil
              }
            },
            unit_price: {
              header: 13,
              converters: {
                "CSVConverter::Converters::BigDecimalConverter" => nil
              }
            },
            unit_cost: {
              header: 14,
              converters: {
                "CSVConverter::Converters::BigDecimalConverter" => nil
              }
            },
            total_revenue: {
              header: 15,
              converters: {
                "CSVConverter::Converters::BigDecimalConverter" => nil
              }
            },
            total_cost: {
              header: 16,
              converters: {
                "CSVConverter::Converters::BigDecimalConverter" => nil
              }
            },
            total_profit: {
              header: 17,
              converters: {
                "CSVConverter::Converters::BigDecimalConverter" => nil
              }
            }
          }
        }
      }
    end
  end
end
