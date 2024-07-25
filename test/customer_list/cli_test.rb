# frozen_string_literal: true

require 'securerandom'
require_relative '../test_helper'
require 'customer_list/cli'

module CustomerList
  class CLITest < Minitest::Test
    class CLI < CustomerList::CLITest
      def test_calls_customer_list_run_method
        expected_args = {
          filename: 'filename.txt',
          delimiter: ',',
          headers: %w[first_name last_name email vehicle_type vehicle_name vehicle_length],
          sort: nil
        }
        actual_args = {}
        method_test_lambda = ->(**args) { actual_args = args }

        CustomerList.stub :run, method_test_lambda do
          CustomerList::CLI.new([expected_args[:filename]]).run
        end

        assert_equal expected_args, actual_args
      end
    end

    class Options < CustomerList::CLITest
      def setup
        super

        @options = CustomerList::CLI::Options.new
      end

      def test_parse_sets_default_values
        @options.parse(['filename.txt'])
        expected_delimiter = ','
        expected_headers = %w[first_name last_name email vehicle_type vehicle_name vehicle_length]

        assert_equal expected_delimiter, @options.delimiter
        assert_equal expected_headers, @options.headers
        assert_nil @options.sort
      end

      def test_parse_sets_custom_values
        expected_delimiter = '|'
        expected_headers = %w[first second third]
        expected_sort = 'third'
        options_arr = [
          '-d', expected_delimiter,
          '-H', expected_headers.join(','),
          '-s', expected_sort,
          'filename.txt'
        ]
        @options.parse(options_arr)

        assert_equal expected_delimiter, @options.delimiter
        assert_equal expected_headers, @options.headers
        assert_equal expected_sort, @options.sort
      end

      def test_parse_raises_error_when_no_file_provided
        error = assert_raises(ArgumentError) do
          @options.parse(['-d', '|'])
        end
        assert_equal 'No file provided', error.message
      end

      def test_parse_raises_error_when_no_headers_provided
        error = assert_raises(ArgumentError) do
          @options.parse(['-H', '', 'filename.txt'])
        end
        assert_equal 'Headers must be provided', error.message
      end

      def test_parse_raises_error_when_no_delimiter_provided
        error = assert_raises(ArgumentError) do
          @options.parse(['-d', '', 'filename.txt'])
        end
        assert_equal 'Delimiter must be provided', error.message
      end

      def test_parse_raises_error_when_sort_field_not_in_headers_or_full_name
        error = assert_raises(ArgumentError) do
          @options.parse(['-s', SecureRandom.hex, 'filename.txt'])
        end
        assert_equal 'Sort field must be one of headers', error.message
      end

      def test_parse_raises_error_when_sort_is_full_name_but_no_first_last_name
        error = assert_raises(ArgumentError) do
          @options.parse(['-s', 'full_name', '-H', 'first_name,email', 'filename.txt'])
        end
        assert_equal 'Can only sort on full name if first and last name are present', error.message
      end

      def test_to_h_returns_hash_of_options
        @options.parse(['filename.txt'])
        expected = {
          delimiter: ',',
          headers: %w[first_name last_name email vehicle_type vehicle_name vehicle_length],
          sort: nil
        }
        actual = @options.to_h

        assert_equal expected, actual
      end

      def test_to_h_raises_error_when_options_not_parsed
        error = assert_raises(StandardError) do
          @options.to_h
        end
        assert_equal 'Options not parsed yet', error.message
      end

      def test_prints_help
        regexp = %r{Usage: \./customer-list \[options\] path/to/file\.ext}
        assert_output(regexp) do
          assert_raises SystemExit do
            @options.parse(['-h'])
          end
        end
      end
    end
  end
end
