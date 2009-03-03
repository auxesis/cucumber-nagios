#!/usr/bin/env ruby 

require 'rubygems'                                                                                      
require 'webrat'
require 'webrat/mechanize'

class MechanizeWorld < Webrat::MechanizeSession
  require 'spec'
  include Spec::Matchers
end

World do
  MechanizeWorld.new
end

def response
  webrat_session.response
end


