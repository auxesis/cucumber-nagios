module Cucumber
  module Nagios
  end
end

begin
  require 'cucumber/nagios/version'
  require 'cucumber/nagios/command'
  require 'net/ssh'
  require 'webrat'
  require 'mq'
rescue LoadError => e
  dep = e.message.split.last
  puts "You don't appear to have #{dep} installed."
  puts "Perhaps run `bundle install` or `gem install #{dep}`?"
  exit 2
end
