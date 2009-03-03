# features/support/nagios.rb
require 'rubygems'

module Nagios
  class NagiosFormatter
    def initialize(io, step_mother, options={})
      @failed = []
      @passed = []
    end

    def step_passed(step, name, params)
      @passed << step
    end

    def step_failed(step, name, params)
      @failed << step
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

