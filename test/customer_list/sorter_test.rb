# frozen_string_literal: true

require_relative '../test_helper'
require 'customer_list/sorter'

module CustomerList
  class SorterTest < Minitest::Test
    def setup
      super

      @list = [
        { 'first_name' => 'John', 'last_name' => 'Doe' },
        { 'first_name' => 'Jane', 'last_name' => 'Smith' }
      ]
    end

    def test_sorts_list_by_field
      expected = @list.sort_by { _1['first_name'] }
      actual = ::CustomerList::Sorter.new(list: @list, sort_field: 'first_name').sort

      assert_equal expected, actual

      expected = @list.sort_by { _1['last_name'] }
      actual = ::CustomerList::Sorter.new(list: @list, sort_field: 'last_name').sort

      assert_equal expected, actual
    end

    def test_can_sort_by_full_name
      expected = @list.sort_by { "#{_1['first_name']} #{_1['last_name']}" }
      actual = ::CustomerList::Sorter.new(list: @list, sort_field: 'full_name').sort

      assert_equal expected, actual
    end
  end
end
