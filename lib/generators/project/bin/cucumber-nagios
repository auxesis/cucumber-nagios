#!/usr/bin/env ruby

unless ARGV[0]
  puts "Usage: #{__FILE__} <feature>"
  exit 99
end

__DIR__ = File.expand_path(File.dirname(__FILE__))

feature = ARGV[0]
unless File.exists?(feature)
  feature = File.join(__DIR__, '..', 'features', ARGV[0]) 
end

unless File.exist?(feature)
  puts "Error: feature file doesn't exist!"
  exit 98
end

command = "#{__DIR__}/cucumber"
command += " --require #{__DIR__}/common.rb"
command += " --require features/"
command += " --format Nagios::NagiosFormatter"
command += " #{feature}"

system(command) ? exit(0) : exit(2)

