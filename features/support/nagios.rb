# features/support/nagios.rb
require 'rubygems'

module Nagios
  class NagiosFormatter
    def initialize(io, step_mother, options={})
      @failed = []
      @passed = []
    end

    def step_passed(*args)
      @passed << true
    end

    def step_failed(*args)
      @failed << true
    end

    def scenario_executed(scenario)
      @total = @failed.size + @passed.size
      message = ""
      message += "Critical: #{@failed.size}, "
      message += "Warning: 0, "
      message += "#{@passed.size} okay"
      # nagios performance data
      message += " | passed=#{@passed.size}"
      message += ", failed=#{@failed.size}, total=#{@total}"
      puts message
    end
  end
end

