# For complete reusable step listings see:
# lib/aruba/cucumber.rb
# https://github.com/aslakhellesoy/aruba/blob/master/lib/aruba/cucumber.rb
# AND
# lib/cuken/*.rb
# https://github.com/hedgehog/cuken

Feature: Installation
  To set up a cucumber-nagios project
  A user
  Must be able to install the gem

  Background:
    Given I build the gem

  @install
  Scenario: Installing the gem
    Given I install the latest gem
    When I successfully run "which cucumber-nagios-gen"
    When I successfully run "which cucumber-nagios"
    Then I successfully run "cucumber-nagios-gen project testproj"

