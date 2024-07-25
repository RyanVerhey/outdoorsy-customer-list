# frozen_string_literal: true

require_relative 'test_helper'
require 'customer_list'

class CustomerListTest < Minitest::Test
  def setup
    super

    @headers = %w[first_name last_name email vehicle_type vehicle_name vehicle_length]
    @rows = [
      ['John', 'Doe',   'jdoe@outdoor.sy',   'Car',   'Toyota', '19 ft'],
      ['Jane', 'Smith', 'jsmith@outdoor.sy', 'Truck', 'Ford',   '24 ft'],
      ['Jim',  'Brown', 'jbrown@outdoor.sy', 'SUV',   'Chevy',  '21 ft']
    ]
    @csv_helper = CSVHelper.new(list: @rows)
  end

  def teardown
    super

    @csv_helper.delete_file
  end

  def test_run_reads_file_and_prints
    delimiter = ','
    @csv_helper.generate_csv_file(delimiter:)
    regexp = /#{@rows.map { _1.join('\s+') }.join('.+')}/im

    assert_output(regexp) do
      ::CustomerList.run(filename: @csv_helper.filepath, delimiter:, headers: @headers, sort: nil)
    end
  end

  def test_run_sorts_by_field_and_prints
    delimiter = ','
    @csv_helper.generate_csv_file(delimiter:)
    regexp = /#{@rows.sort_by { _1[1] }.map { _1.join('.+') }.join('.+')}/im

    assert_output(regexp) do
      ::CustomerList.run(filename: @csv_helper.filepath, delimiter:, headers: @headers, sort: 'last_name')
    end
  end
end
