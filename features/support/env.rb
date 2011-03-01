#!/usr/bin/env ruby
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

$: << File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib'))
$: << File.expand_path(File.dirname(__FILE__))

require 'cucumber/nagios/steps'
require 'webrat_logging_patches'

World do
  Webrat::Session.new(Webrat::MechanizeAdapter.new)
end

require 'cuken/common'
require 'cuken/ssh'
require 'cuken/cmd'
require 'cuken/file'
