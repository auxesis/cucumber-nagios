# Most steps are now described using Aruba's steps.
#
# For an example see:
# ./cucumber-nagios/features/ssh.feature
#
# For step definitions see:
# ./cucumber-nagios/lib/cuken/cucumber/ssh.rb
#
# For the SSH api see:
# ./cucumber-nagios/lib/cuken/api/ssh.rb
#
# To use step definitions in your cucumber
# feature files, add to env.rb:
#
# require 'cuken/ssh'
#
# Enjoy.
#

#
# Some WWW access features/steps can take a while:
#
Before do
  @aruba_timeout_seconds.nil? || @aruba_timeout_seconds < 30 ? @aruba_timeout_seconds = 10 : @aruba_timeout_seconds
end
