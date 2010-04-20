require 'cucumber/nagios'

#For standalone execution

require 'webrat/adapters/mechanize'

class ResponseHelper
  def response
    webrat_session.response
  end
end

World do
  ResponseHelper.new
  Webrat::Session.new(Webrat::MechanizeAdapter.new)
end