# For complete Aruba step listing see:
# lib/aruba/cucumber.rb
# or https://github.com/aslakhellesoy/aruba/blob/master/lib/aruba/cucumber.rb
Feature: Executing commands
  In order to test a running local system
  As an administrator
  I want to use Aruba steps to run commands and test output

  Background:
    Given that "cuken/cmd" is required

  Scenario: Check Stdout
    When I do aruba I run "echo 'i like cheese'"
    Then I see aruba the stdout from "echo 'i like cheese'" should contain "i like cheese"

  Scenario: Check Stderr
    When I do aruba I run "echo 'i like cheese' 1>&2"
    Then I see aruba the stderr from "echo 'i like cheese' 1>&2" should contain "i like cheese"

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

