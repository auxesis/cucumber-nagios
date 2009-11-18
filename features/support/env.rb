#!/usr/bin/env ruby

generator_root = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "lib", "generators", "project"))

Dir.glob(File.join(generator_root, "features", "support",  "*.rb" ))).each do |support_file|
  require support_file
end

Dir.glob(File.join(generator_root, "features", "steps",  "*.rb" ))).each do |step_file|
  require step_file
end

