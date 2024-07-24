# frozen_string_literal: true

require 'console_table'

module CustomerList
  # Prints the customer list
  class Printer
    attr_reader :list, :headers

    def initialize(list:, headers:)
      @list = list
      @headers = headers
    end

    def print
      ConsoleTable.define(table_config) do |table|
        @list.each do |row|
          table << row.to_h
        end
      end
    end

    private

    def table_config
      headers.map do |header|
        { key: header, title: header, size: '*' }
      end
    end
  end
end
