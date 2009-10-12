#!/usr/bin/env ruby 

require 'rubygems'                                                                                      
require 'webrat'
require 'webrat/mechanize'

class ResponseHelper
  def response
    webrat_session.response
  end
end

World do
  ResponseHelper.new
  Webrat::Session.new(Webrat::MechanizeAdapter.new)
end


