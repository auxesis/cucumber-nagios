# For complete reusable step listings see:
# lib/aruba/cucumber.rb
# https://github.com/aslakhellesoy/aruba/blob/master/lib/aruba/cucumber.rb
# AND
# lib/cuken/*.rb
# https://github.com/hedgehog/cuken

Feature: Creating new project
  To test websites
  A cucumber-nagios project
  Must be created

  Background:
    Given cucumber-nagios is installed

  @create
  Scenario: Create a project
    Given I successfully run "cucumber-nagios-gen project great-website-tests"
    When I cd to "great-website-tests"
    Then these directories exist:
      | features/steps                      |
      | features/support                    |
    And these files exist:
      | features/support/env.rb             |
      | features/steps/amqp_steps.rb        |
      | features/steps/benchmark_steps.rb   |
      | features/steps/command_steps.rb     |
      | features/steps/dns_steps.rb         |
      | features/steps/file_steps.rb        |
      | features/steps/http_header_steps.rb |
      | features/steps/http_steps.rb        |
      | features/steps/ping_steps.rb        |
      | features/steps/ssh_steps.rb         |

  @create
  Scenario: Pretend to create a project
    Given I successfully run "cucumber-nagios-gen project --pretend greatest-website-tests"
    Then these directories do not exist:
      | greatest-website-tests/features/steps    |
      | greatest-website-tests/features/support  |
