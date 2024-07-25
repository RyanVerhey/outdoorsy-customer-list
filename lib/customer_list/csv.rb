# frozen_string_literal: true

require 'csv'

module CustomerList
  # Reads a CSV file and outputs as an instance of a Data class
  class CSV
    def initialize(filename:, delimiter:, headers:)
      @filename = filename
      @delimiter = delimiter
      @headers = headers
    end

    def read
      ::CSV.foreach(@filename, headers: @headers, col_sep: @delimiter).map(&:to_h)
    end
  end
end
