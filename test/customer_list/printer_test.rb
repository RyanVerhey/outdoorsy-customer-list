# frozen_string_literal: true

require_relative '../test_helper'
require 'customer_list/printer'

module CustomerList
  class PrinterTest < Minitest::Test
    def test_prints_list
      list = [
        { 'first_name' => 'John', 'last_name' => 'Doe' }
      ]
      regexp = /#{list.first.keys.join('.+')}.+#{list.first.values.join('.+')}/im

      assert_output(regexp) do
        ::CustomerList::Printer.new(list:, headers: list.first.keys).print
      end
    end
  end
end
