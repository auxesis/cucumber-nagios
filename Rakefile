#!/usr/bin/env ruby 

require 'rubygems'
require 'fileutils'

begin 
  require 'cucumber/rake/task'
   
  Cucumber::Rake::Task.new do |t|
    t.cucumber_opts = "--require features/"
  end
rescue LoadError
end


desc "build gem"
task :build do 
  system("gem build cucumber-nagios.gemspec")

  FileUtils.mkdir_p('pkg')
  puts
  Dir.glob("cucumber-nagios-*.gem").each do |gem|
    dest = File.join('pkg', gem)
    FileUtils.mv(gem, dest)
    puts "New gem in #{dest}"
  end
end
