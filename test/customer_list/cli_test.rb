# frozen_string_literal: true

require_relative '../test_helper'
require 'customer_list/cli'

class CustomerList::CLITest < Minitest::Test
  class CLI < CustomerList::CLITest
    def test_run_reads_file_and_prints
      skip 'TBD'
    end

    def test_run_sorts_by_field_and_prints
      skip 'TBD'
    end

    def test_can_pass_custom_headers
      skip 'TBD'
    end
  end

  class Options < CustomerList::CLITest
    def test_parse_sets_default_values
      skip 'TBD'
    end

    def test_parse_sets_custom_values
      skip 'TBD'
    end

    def test_parse_raises_error_when_no_file_provided
      skip 'TBD'
    end

    def test_parse_raises_error_when_no_headers_provided
      skip 'TBD'
    end

    def test_parse_raises_error_when_no_delimiter_provided
      skip 'TBD'
    end

    def test_parse_raises_error_when_sort_field_not_in_headers
      skip 'TBD'
    end

    def test_to_h_raises_error_when_options_not_parsed
      skip 'TBD'
    end

    def test_prints_help
      skip 'TBD'
    end
  end
end
