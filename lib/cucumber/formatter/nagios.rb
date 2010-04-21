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
        record_result(status, :step_match => step_match)
      end

      def before_examples(*args)
        @header_row = true
      end

      def after_table_row(table_row)
        unless @header_row 
          record_result(table_row.status) if table_row.respond_to?(:status)
        end
        @header_row = false if @header_row
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
      
      def record_result(status, opts={})
        step_match = opts[:step_match] || true
        case status
        when :passed
          @passed << step_match
        when :failed
           @failed << step_match
        when :undefined
          @warning << step_match
        end
      end


    end
  end
end

