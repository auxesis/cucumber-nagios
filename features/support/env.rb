#!/usr/bin/env ruby

$: << File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib'))

require 'cucumber/nagios/steps'

World do
  Webrat::Session.new(Webrat::MechanizeAdapter.new)
end
