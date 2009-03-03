# features/support/nagios.rb
require 'rubygems'

module Nagios
  class NagiosFormatter
    def initialize(io, step_mother, options={})
      # We don't care about these - we're just twittering!
      @failed = []
      @passed = []
    end

    def scenario_executing(scenario)
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
      message += " | value=#{sprintf("%.6f", (@total - @failed.size))};;;;"
      puts message
    end
  end
end

