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
      list.sort_by { _1[sort_field] }
    end
  end
end
