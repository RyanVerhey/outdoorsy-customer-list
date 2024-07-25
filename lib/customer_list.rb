# frozen_string_literal: true

require_relative 'customer_list/csv'
require_relative 'customer_list/sorter'
require_relative 'customer_list/printer'

# Acts as a namespace and controller for the customer list
module CustomerList
  FULL_NAME_SORT_FIELD = 'full_name'
  FIRST_NAME_SORT_FIELD = 'first_name'
  LAST_NAME_SORT_FIELD = 'last_name'

  def self.run(filename:, delimiter:, headers:, sort:)
    customer_list = CustomerList::CSV.new(filename:, delimiter:, headers:).read
    customer_list = CustomerList::Sorter.new(list: customer_list, sort_field: sort).sort if sort
    CustomerList::Printer.new(list: customer_list, headers:).print
  end
end
