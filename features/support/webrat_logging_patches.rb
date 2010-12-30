#!/usr/bin/env ruby

# Suppress logs being written to ./webrat.log
module Webrat
  module Logging
    def logger
      nil
    end
  end
end
