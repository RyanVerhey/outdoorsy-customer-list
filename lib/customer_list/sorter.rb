# frozen_string_literal: true

module CustomerList
  # Class for sorting customer list by field
  class Sorter
    attr_reader :list, :sort_field

    def initialize(list:, sort_field:)
      @list = list
      @sort_field = sort_field
    end

    def sort
      list.sort_by do |row|
        # If the sort field is full_name, sort by first_name and last_name
        if @sort_field == FULL_NAME_SORT_FIELD
          "#{row[FIRST_NAME_SORT_FIELD]} #{row[LAST_NAME_SORT_FIELD]}"
        else
          row[sort_field]
        end
      end
    end
  end
end
