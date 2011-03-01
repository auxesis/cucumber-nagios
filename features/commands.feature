# For complete reusable step listings see:
# lib/aruba/cucumber.rb
# https://github.com/aslakhellesoy/aruba/blob/master/lib/aruba/cucumber.rb
# AND
# lib/cuken/*.rb
# https://github.com/hedgehog/cuken

Feature: Executing commands
  In order to test a running local system
  As an administrator
  I want to use Aruba steps to run commands and test output

  Scenario: Check Stdout
    When I run "echo 'i like cheese'"
    Then the stdout from "echo 'i like cheese'" should contain "i like cheese"

  Scenario: Check Stderr
    When I run "some_error"
    Then the stderr from "some_error" should contain "No such file or directory - some_error"

  Scenario: Check Stdout for multiple lines
    When I run "echo 'one\none\none\n'"
    Then the output should contain:
    """
    one
    one
    one
    """

  Scenario: Check exit code
    When I run "true"
    Then the exit status should be 0

  Scenario: Check exit code
    When I run "false"
    Then the exit status should be 1

