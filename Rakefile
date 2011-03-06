#!/usr/bin/env ruby

begin
  require 'bundler'
  Bundler::GemHelper.install_tasks
rescue LoadError
  puts "Bundler not available. Install it with: gem install bundler"
end

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)
rescue LoadError
  task :features do
    abort "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
  end
end

task :default => :features

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "cucumber-nagios #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end


require "rake/clean"
file 'MANIFEST.tmp' do
  # generate manifest from everything checked into git
  # this allows us to ignore things using .gitignore
  sh %{git ls-files > MANIFEST.tmp}
end
CLEAN << 'MANIFEST.tmp'

desc "Check the manifest against current files"
task :check_manifest => [:clean, 'MANIFEST', 'MANIFEST.tmp'] do
  puts `diff -du MANIFEST MANIFEST.tmp`
end

CLEAN << '*.gem'
