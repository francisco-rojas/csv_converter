# csv_converter [![Build Status](https://travis-ci.org/francisco-rojas/basic_ruby.svg?branch=master)](https://travis-ci.org/francisco-rojas/basic_ruby)

csv_converter is a library for facilitating the conversion of data provided in .csv files.
This library is NOT for parsing .csv files. There are already plenty of libraries out there for reading and parsing .csv files, including the ruby standard library. Instead, this library focuses on the conversion of the data provided in the .csv files. Often times, it is required to cast the string data into a ruby object, perform validations on that data, and map it to the corresponding tables and table columns in the database. This library aims to make that process as simple as possible.

For example, given the following csv:

```
Sales Region,Sales Country,Sale Completed,Sale Notes,Item Type,Item Code,Item Description,Sale Channel,Order Priority,Order Date (mm/dd/yy),Order #,Order Ship Date,Order Units Sold,Order Unit Price,Order Unit Cost,Total Revenue
Middle East and North Africa,Libya,Y,"LoremIpsum",Cosmetics,1031422,"Lorem ipsum",Offline,m,10/18/14,686800706,10/31/14,8446,437.2,263.33,3692591.2,2224085.18,1468506.02
```

you might want something like this:

```ruby
{
    sale: {
        region: "Middle East and North Africa",
        country: "Libya",
        completed: true,
        notes: "LoremIpsum",
        channel: "Offline"
    },
    item: {
        type: "Cosmetics",
        code: "1031422",
        description: "Lorem ipsum"
    },
    order: {
        priority: "M",
        date: #<Date: 2014-10-18 ((2456949j,0s,0n),+0s,2299161j)>,
        number: "686800706",
        shipping_date: #<Date: 2014-10-31 ((2456962j,0s,0n),+0s,2299161j)>,
        units_sold: 8446,
        unit_price: 0.4372e3,
        unit_cost: 0.26333e3,
        total_revenue: 0.36925912e7,
        total_cost: 0.222408518e7,
        total_profit: 0.146850602e7
    }
}
```

here, each column from the csv has been group according to the corresponding table in the database where the data will be stored. Also, the data for each column has been converted to the expected data type.

All this is performed by csv_converter based on the mappings provieded for the file in a .yml config file that lookes like this:

```
truthy_values: &default_truthy_values
  - "Yes"
  - "YES"
  - "Y"
  - "y"

empty_values: &default_empty_values
  - "NA"
  - "na"
  - "N/A"
  - "n/a"

mappings:
  sale:
    region:
      header: Sales Region
      converters:
        CSVConverter::Converters::StringConverter:
    country:
      header: Sales Country
      converters:
        CSVConverter::Converters::StringConverter:
    completed:
      header: Sale Completed
      converters:
        CSVConverter::Converters::BooleanConverter:
          truthy_values: *default_truthy_values
    notes:
      header: Sale Notes
      converters:
        CSVConverter::Converters::StringConverter:
          empty_values: *default_empty_values
    channel:
      header: Sale Channel
      converters:
        CSVConverter::Converters::StringConverter:
  item:
    type:
      header: Item Type
      converters:
        CSVConverter::Converters::StringConverter:
          default: Article
    code:
      header: Item Code
      converters:
        CSVConverter::Converters::StringConverter:
    description:
      header: Item Description
      converters:
        CSVConverter::Converters::StringConverter:
  order:
    priority:
      header: Order Priority
      converters:
        CSVConverter::Converters::StringConverter:
        CSVConverter::Converters::UppercaseConverter:
    date:
      header: Order Date (mm/dd/yy)
      converters:
        CSVConverter::Converters::DateConverter:
          date_format: "%m/%d/%y"
    number:
      header: "Order #"
      converters:
        CSVConverter::Converters::StringConverter:
    shipping_date:
      header: Order Ship Date
      converters:
        CSVConverter::Converters::DateConverter:
          date_format: "%m/%d/%y"
    units_sold:
      header: Order Units Sold
      converters:
        CSVConverter::Converters::IntegerConverter:
    unit_price:
      header: Order Unit Price
      converters:
        CSVConverter::Converters::BigDecimalConverter:
    unit_cost:
      header: Order Unit Cost
      converters:
        CSVConverter::Converters::BigDecimalConverter:
    total_revenue:
      header: Total Revenue
      converters:
        CSVConverter::Converters::BigDecimalConverter:
    total_cost:
      header: Total Cost
      converters:
        CSVConverter::Converters::BigDecimalConverter:
    total_profit:
      header: Total Profit
      converters:
        CSVConverter::Converters::BigDecimalConverter:
```

THIS IS STILL A WORK IN PROGRESS! I am continually working on this and I am hoping to release the first version in the following weeks. If you have any feature suggestions feel free to reach me at: josefcorojas@gmail.com

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'csv_converter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install csv_converter

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/csv_converter.
