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


desc "freeze deps"
task :deps do 
  deps = ['cucumber', 'webrat', 'mechanize']
  deps.each do |dep|
    puts "installing #{dep}"
    system("gem install #{dep} -i gems --no-rdoc --no-ri")
  end
end
