#!/usr/bin/env ruby
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

$: << File.expand_path(File.dirname(__FILE__))

require 'cucumber/nagios'
require 'webrat/adapters/mechanize'
require 'webrat_logging_patches'

class ResponseHelper
  def response
    webrat_session.response
  end
end

World do
  ResponseHelper.new
  Webrat::Session.new(Webrat::MechanizeAdapter.new)
end

require 'cuken/ssh'
require 'cuken/cmd'
require 'cuken/file'

require 'rspec/expectations'
