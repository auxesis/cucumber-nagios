#!/usr/bin/env ruby

Dir[
  File.expand_path(
    File.join(
      File.dirname(__FILE__), 
      "..", 
      "..", 
      "lib", 
      "generators", 
      "project", 
      "features", 
      "support", 
      "*.rb"
    )
  )
].each do |support_file|
  require support_file
end

Dir[
  File.expand_path(
    File.join(
      File.dirname(__FILE__), 
      "..", 
      "..", 
      "lib", 
      "generators", 
      "project", 
      "features", 
      "steps", 
      "*.rb"
    )
  )
].each do |step_file|
  require step_file
end

