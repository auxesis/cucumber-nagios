require 'cucumber/formatter/console'

module Cucumber
  module Formatter
    class Nagios

      def initialize(step_mother, io, options)
        @step_mother = step_mother
        @options = options
        @failed  = []
        @passed  = []
        @warning = []
        @io = io
        @message = []
        @start_time = Time.now
      end

      def after_step_result(keyword, step_match, multiline_arg, status, exception, source_indent, background, scenario_line_num)
        record_result(status, :step_match => step_match, :keyword => keyword)
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

      def scenario_name(keyword, name, file_colon_line, source_indent)
        @scenario_file_colon_line = file_colon_line
      end

      private
      def print_summary
        @total    = @failed.size + @passed.size + @warning.size
        @status   = @failed.size > 0 && "CRITICAL" || @warning.size > 0 && "WARNING" || "OK"
        @run_time = ((Time.now - @start_time)*100).round/100.0

        service_output   = [ "CUCUMBER #{@status} - Critical: #{@failed.size}",
                             "Warning: #{@warning.size}", "#{@passed.size} okay" ]
        performance_data = [ "passed=#{@passed.size}", "failed=#{@failed.size}",
                             "nosteps=#{@warning.size}", "total=#{@total}",
                             "time=#{@run_time}" ]
        @message << "#{service_output.join(', ')} | #{performance_data.join('; ')}"

        @failed.each do |keyword, step_match, scenario_file_colon_line|
          @message << "Failed: #{keyword}#{step_match.instance_variable_get("@name_to_match")} in #{scenario_file_colon_line} on #{step_match.file_colon_line}"
        end

        message = @message.join("\n") + "\n"
        @io.print(message)
        @io.flush
      end

      def record_result(status, opts={})
        step_match = opts[:step_match] || true
        keyword    = opts[:keyword]
        case status
        when :passed
          @passed  << [ keyword, step_match, @scenario_file_colon_line ]
        when :failed
          @failed  << [ keyword, step_match, @scenario_file_colon_line ]
        when :undefined
          @warning << [ keyword, step_match, @scenario_file_colon_line ]
        end
      end

    end
  end
end

