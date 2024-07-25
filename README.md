# Outdoors.sy Customer List

## About
For-fun sample project.

Premise: A small tool for a fictional company called Outdoor.sy that takes some of their customer lists and returns the data in different sorted orders

**Requirements**:
- Add data from a given file
  - By default, files will have the following headers: First name, Last name, Email, Vehicle type, Vehicle name, and Vehicle length
- Display the information from the file
- Sort the data

## Installation
Prerequisites:
- bundler
- Ruby >= 3.1

To install, install the dependencies:
```sh
bundle install
```

## Usage
To use this software, run the `customer-list` file with a filename:
```sh
./customer-list /path/to/file.ext
```

It assumes the delimiter/column separator for the file is a comma (`,`).
Custom delimiters can be passed in as such:
```sh
./customer-list -d '|' /path/to/file.ext
```

It assumes the headers for the file are: `first_name, last_name, email, vehicle_type, vehicle_name, vehicle_length`.
Custom headers can be passed in as such:
```sh
./customer-list -H last_name,email,other /path/to/file.ext
```

The output table can also be sorted. Just pass in the name of one of the headers:
```sh
./customer-list -s last_name
```

The only exception to the above is that the rows can also be sorted by full name (`first_name + ' ' + last_name`):
```sh
./customer-list -s full_name
```

## Test Suite
This test suite has 100% code coverage, and no linter or type errors.

### Tests
This codebase uses [Rake](https://github.com/ruby/rake) & [MiniTest](https://github.com/minitest/minitest) for unit tests. The tests are stored in the `test/` directory. To run the tests:
```sh
bundle exec rake test
```
### Linter
We use [Rubocop](https://github.com/rubocop/rubocop) for linting. To run the linter:
```sh
bundle exec rubocop
```
### Type Checker
We use [RBS](https://github.com/ruby/rbs), via [Steep](https://github.com/soutaro/steep), for type checking. Type definitions are stored in the `sig/` directory.
To run the type checker, first you need to install the RBS gem collection:
```sh
bundle exec rbs collection update
```
Then, you can call Steep to do the type checking:
```sh
bundle exec steep check
```
