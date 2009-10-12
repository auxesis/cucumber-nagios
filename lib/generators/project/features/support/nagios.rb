require 'cucumber/formatter/console'

module Cucumber
  module Formatter
    class Nagios

      def initialize(step_mother, io, options={})
        @failed  = []
        @passed  = []
        @warning = []
        @io = io
      end
  
      def after_step_result(keyword, step_match, multiline_arg, status, exception, source_indent, background)
        case status
        when :passed
          @passed << step_match
        when :failed
           @failed << step_match
        when :undefined
          @warning << step_match
        end
      end
  
      def after_features(steps)
        print_summary
      end
  
      private
      def print_summary
        @total = @failed.size + @passed.size + @warning.size
        message = ""
        message += "Critical: #{@failed.size}, "
        message += "Warning: #{@warning.size}, "
        message += "#{@passed.size} okay"
        # nagios performance data
        message += " | passed=#{@passed.size}"
        message += ", failed=#{@failed.size}"
        message += ", nosteps=#{@warning.size}"
        message += ", total=#{@total}\n"

        @io.print(message)
        @io.flush
      end

    end
  end
end

