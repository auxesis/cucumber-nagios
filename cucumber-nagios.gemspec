# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'cucumber/nagios/version'

Gem::Specification.new do |s|
  s.name        = "cucumber-nagios"
  s.platform    = Gem::Platform::RUBY
  s.version     = Cucumber::Nagios::VERSION
  s.summary     = "Systems testing plugin for Nagios using Cucumber."
  s.description = "cucumber-nagios helps you write behavioural tests for your systems and infrastructure, that can be plugged into Nagios."
  s.homepage    = "http://cucumber-nagios.org/"

  s.authors     = ["Lindsay Holmwood"]
  s.email       = ["lindsay@holmwood.id.au"]

  s.require_paths      = ["lib"]
  s.files              = `git ls-files`.split(/\r?\n\r?/)
  s.executables        = s.files.grep(/^bin/) { |f| File.basename(f) }
  s.default_executable = "cucumber-nagios"
  s.extra_rdoc_files   = s.files.grep(/^[A-Z]+(\.md)*$/)

  s.add_runtime_dependency     "cucumber", ">= 0.10.0"
  s.add_runtime_dependency     "rspec", ">= 2.3.0"
  s.add_runtime_dependency     "webrat", "= 0.7.2"
  s.add_runtime_dependency     "mechanize", "= 1.0.0"
  s.add_runtime_dependency     "templater", ">= 1.0.0"
  s.add_runtime_dependency     "net-ssh", "~> 2.1.0"
  s.add_runtime_dependency     "amqp", "= 0.6.7"
  s.add_runtime_dependency     "bundler", "~> 1.0.7"
  s.add_development_dependency "rake", ">= 0.8.3"
end
