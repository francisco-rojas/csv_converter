# csv_converter [![Build Status](https://travis-ci.org/francisco-rojas/basic_ruby.svg?branch=master)](https://travis-ci.org/francisco-rojas/basic_ruby)

*csv_converter* is a library for facilitating the grouping and transformation of tabulated data contained in files such as csv or spreadsheets files. This is **not** a library for parsing files. There are already plenty of libraries out there for reading and parsing files in different formats.

Instead, this library focuses on the conversion of the data provided in the files. Often times, it is required to cast the text data into a ruby object, perform validations on that data, and map it to the corresponding db tables/models and columns/attributes. This library aims to simplify that process.

For example, given the following csv content:

```
First Name,Last Name,Make,Model,Year,Color,Purchase Date
John,Smith,Ford,Mustang,2000,Black,25/01/99
Julian,Moore,Toyota,Yaris,2005,Red,13/04/05
Joe,Black,Volvo,V40,2015,Gold,03/02/16
```

| First Name  | Last Name | Make    | Model   | Year | Color | Purchase Date |
| ----------- | --------- | ------- | ------- | ---- | ----- | ------------- |
| John        | Smith     | Ford    | Mustang | 2000 | Black | 25/01/99      |
| Julian      | Moore     | Toyota  | Yaris   | 2005 | Red   | 13/04/05      |
| Joe         | Black     | Volvo   | V40     | 2015 | Gold  | 03/02/16      |


you might want something like this:

```ruby
[
  {
    "owner" => {
      "first_name" => "John",
      "last_name" => "Smith"
    },
    "vehicle" => {
      "make" => "Ford",
      "model" => "Mustang",
      "year" => 2000,
      "color" => "Black",
      "purchase_date" => #<Date: 1999-01-25 ((2451204j,0s,0n),+0s,2299161j)>
    }
  },
  {
    "owner" => {
      "first_name" => "Julian",
      "last_name" => "Moore"
    },
    "vehicle" => {
      "make" => "Toyota",
      "model" => "Yaris",
      "year" => 2005,
      "color" => "Red",
      "purchase_date" => #<Date: 2005-04-15 ((2453476j,0s,0n),+0s,2299161j)>
    }
  },
  {
    "owner" => {
      "first_name" => "Joe",
      "last_name" => "Black"
    },
    "vehicle" => {
      "make" => "Volvo",
      "model" => "V40",
      "year" => 2015,
      "color" => "Gold",
      "purchase_date" => #<Date: 2016-03-02 ((2457450j,0s,0n),+0s,2299161j)>
    }
  }
]
```

In this example, each column from the csv has been grouped according to the configuration provided. Also, the data for each column has been converted to the expected data type.

This is performed by *csv_converter* based on the configuration provided in a .yml file (or a ruby hash) that lookes like this:

```
owner:
  first_name:
    header: First Name
  last_name:
    header: Last Name
vehicle:
  make:
    header: Make
  model:
    header: Model
  year:
    header: Year
    converters:
      integer:
  color:
    header: Color
  purchase_date:
    header: Purchase Date
    converters:
      date:
        date_format: "%m/%d/%y"
```

## Usage

*csv_converter* supports more advanced data conversions, processing data based on column position instead of headers and nested records within a column.

Please refer to the [*wiki page*](https://github.com/francisco-rojas/csv_converter/wiki) for further instructions and more advanced examples.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'csv_converter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install csv_converter

## Documentation
You can view the csv_converter documentation in RDoc format here:

https://rubydoc.info/github/francisco-rojas/csv_converter/master

You can also view the wiki here:

https://github.com/francisco-rojas/csv_converter/wiki

Finally, you can check the Readme and source code here:

https://github.com/francisco-rojas/csv_converter

## Development

Currently, the library is stable. I believe it supports the most common use cases so most likely the code won't be updated very frequently. However, if you have any feature requests or find a bug feel free to open a github issue and I will reply as soon as I can.

- for **feature requests** please use the **enhancement** label.
- for **bugs** please use the **bugs** label.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/francisco-rojas/csv_converter

## License

MIT License. Copyright 2019 Francisco Rojas. https://github.com/francisco-rojas
