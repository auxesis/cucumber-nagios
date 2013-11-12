#!/usr/bin/env ruby

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
