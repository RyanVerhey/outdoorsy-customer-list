# frozen_string_literal: true

require 'optparse'

require_relative '../customer_list'

module CustomerList
  # Command line interface for the customer list
  class CLI
    attr_reader :argv

    def initialize(argv)
      @argv = argv
    end

    def run
      options = Options.new
      options.parse(@argv)
      opt_hash = options.to_h
      filename = @argv.first.to_s
      delimiter = opt_hash[:delimiter]
      headers = opt_hash[:headers]
      sort = opt_hash[:sort]

      CustomerList.run(filename:, delimiter:, headers:, sort:)
    end

    # Represents the options that can be passed to the CLI
    class Options
      VALID_OPTIONS = %i[delimiter headers sort].freeze
      attr_accessor(*VALID_OPTIONS)

      def initialize
        self.delimiter = ','
        self.headers = %w[first_name last_name email vehicle_type vehicle_name vehicle_length]
        self.sort = nil
        @parsed = false
      end

      def parse(options)
        OptionParser.new do |parser|
          define_options(parser)
          parser.parse!(options)
          @parsed = true
          validate_options(options)
        end
      end

      def to_h
        # Outputting the options so they can be read later
        raise 'Options not parsed yet' unless @parsed

        VALID_OPTIONS.each_with_object({}) do |option, hash|
          hash[option] = send(option)
        end
      end

      private

      def validate_options(options)
        validate_file(options)
        validate_headers(headers)
        validate_delimiter(delimiter)
        validate_sort(sort)
      end

      def define_options(parser)
        parser.banner = 'Usage: ./customer-list [options] path/to/file.ext'
        perform_delimiter_option(parser)
        perform_headers_option(parser)
        perform_sort_option(parser)

        parser.on_tail('-h', '--help', 'Show this message') do
          puts parser
          exit
        end
      end

      def perform_delimiter_option(parser)
        parser.on('-d', '--delimiter DELIMITER',
                  "Delimiter for the input file (default `#{delimiter}`)") do |delimiter|
          self.delimiter = delimiter
        end
      end

      def perform_headers_option(parser)
        parser.on('-H', '--headers x,y,z', Array,
                  "Headers for the input file (default `#{headers.join(',')}`)") do |headers|
          self.headers = headers
        end
      end

      def perform_sort_option(parser)
        parser.on('-s', '--sort [FIELD]', 'Sort by the given field') do |sort|
          self.sort = sort
        end
      end

      def validate_file(options)
        raise ArgumentError, 'No file provided' if options.empty?
      end

      def validate_headers(headers)
        raise ArgumentError, 'Headers must be provided' if headers.empty?
      end

      def validate_delimiter(delimiter)
        raise ArgumentError, 'Delimiter must be provided' if delimiter.empty?
      end

      def validate_sort(sort)
        return unless sort

        # We want to make sure that the sort field is either in the headers or is full_name
        if !headers.include?(sort) && sort != FULL_NAME_SORT_FIELD
          raise ArgumentError, 'Sort field must be one of headers'
        end

        # Checking that headers includes first and last name if sorting by full name
        return unless sort == 'full_name' && (headers & %w[first_name last_name]).size < 2

        raise ArgumentError, 'Can only sort on full name if first and last name are present'
      end
    end
  end
end
