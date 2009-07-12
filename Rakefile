#!/usr/bin/env ruby 

require 'rubygems'

begin 
  require 'cucumber/rake/task'
   
  Cucumber::Rake::Task.new do |t|
    t.binary = "bin/cucumber"
    t.cucumber_opts = "--require bin/common.rb --format Nagios::NagiosFormatter"
  end
rescue LoadError
end


desc "build gem"
task :build do 
  system("gem build cucumber-nagios.gemspec")
end
