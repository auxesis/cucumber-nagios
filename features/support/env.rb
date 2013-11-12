#!/usr/bin/env ruby

$: << File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib'))
$: << File.expand_path(File.dirname(__FILE__))

require 'cucumber/nagios/steps'
require 'webrat_logging_patches'

World do
  Webrat::Session.new(Webrat::MechanizeAdapter.new)
end
