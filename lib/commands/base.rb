require 'rubygems'
require 'optparse'

module Commands
  class Base

    attr_accessor :input, :output, :options

    def initialize(input=STDIN, output=STDOUT, *args)
      @input = input
      @output = output
      @options = {}

      parse_argv(*args)
    end

    def put(string, newline=true)
      @output.print(newline ? string + "\n" : string) unless options[:quiet]
    end

    def sys(cmd)
      put cmd if options[:verbose]
      system "#{cmd} > /dev/null 2>&1"
    end

    def get(cmd)
      put cmd if options[:verbose]
      `#{cmd}`
    end

    def run!
      return 0
    end

  protected

    def current_branch
      @current_branch ||= get('git symbolic-ref HEAD').chomp.split('/').last
    end

    def integration_branch
      options[:integration_branch] || "master"
    end

  private

    def parse_argv(*args); end

  end
end

