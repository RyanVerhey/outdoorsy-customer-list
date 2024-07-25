# frozen_string_literal: true

require 'csv'
require 'stringio'
require_relative '../test_helper'
require 'customer_list/csv'

module CustomerList
  class CSVTest < Minitest::Test
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

    def generate_csv_file(delimiter = ',')
      @csv_helper.generate_csv_file(delimiter:)
    end

    def test_read_returns_array_of_hashes
      generate_csv_file

      expected = @rows.map { @headers.zip(_1).to_h }
      actual = CustomerList::CSV.new(
        filename: @csv_helper.filepath,
        delimiter: ',',
        headers: @headers
      ).read

      assert_equal expected, actual
    end

    def test_can_accept_custom_delimiter
      delimiter = '|'
      generate_csv_file delimiter

      expected = @rows.map { @headers.zip(_1).to_h }
      actual = CustomerList::CSV.new(
        filename: @csv_helper.filepath,
        delimiter:,
        headers: @headers
      ).read

      assert_equal expected, actual
    end
  end
end
