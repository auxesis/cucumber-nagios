#!/usr/bin/env ruby

require 'rubygems'
require 'rake'
require 'lib/cucumber/nagios/version'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "cucumber-nagios"
    gem.summary = "Systems testing plugin for Nagios using Cucumber/Webrat/Mechanize/net-ssh."
    gem.description = "cucumber-nagios helps you write high-level behavioural tests for your web applications and Unix infrastructure that can be plugged into Nagios."
    gem.email = "lindsay@holmwood.id.au"
    gem.homepage = "http://cucumber-nagios.org/"
    gem.authors = ["Lindsay Holmwood"]
    gem.has_rdoc = false
    gem.version = Cucumber::Nagios::VERSION

    gem.add_dependency('cucumber', '>= 0.10.0')
    gem.add_dependency('rspec', '>= 2.3.0')
    gem.add_dependency('webrat', '= 0.7.2')
    gem.add_dependency('mechanize', '= 1.0.0')
    gem.add_dependency('templater', '>= 1.0.0')
    gem.add_dependency('net-ssh', '= 2.0.18')
    gem.add_dependency('amqp', '= 0.6.7')
    gem.add_dependency('bundler', '= 1.0.7')

    gem.add_development_dependency('rake', '>= 0.8.3')

    gem.bindir = "bin"
    gem.executables = %w(cucumber-nagios-gen)
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)

  task :features => :check_dependencies
rescue LoadError
  task :features do
    abort "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
  end
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "cucumber-nagios #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
