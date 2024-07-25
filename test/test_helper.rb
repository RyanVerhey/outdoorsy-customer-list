# frozen_string_literal: true

require 'csv'
require 'simplecov'
require 'simplecov-console'
SimpleCov.formatter = SimpleCov::Formatter::Console
SimpleCov.start do
  add_filter '/test/'
end

require 'minitest/autorun'

class CSVHelper
  attr_reader :filepath

  def initialize(list:)
    @filepath = File.expand_path(File.join(File.dirname(__FILE__), 'tmp', 'customers.txt'))
    @list = list
  end

  def generate_csv_file(delimiter: ',')
    File.write(@filepath, CSV.generate_lines(@list, col_sep: delimiter))
  end

  def delete_file
    File.delete(@filepath)
  end
end
