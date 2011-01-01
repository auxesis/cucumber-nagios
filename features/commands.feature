Feature: Executing commands
  In order to test a running system
  As an administrator
  I want to run arbitrary commands and test the output

  @steps
  Scenario: Check Stdout
    When I run 'echo "i like cheese"'
    Then 'stdout' should have 'i like cheese'

  @steps
  Scenario: Check Stderr
    When I run 'echo "i like cheese" 1>&2'
    Then 'stderr' should have 'i like cheese'

  @steps
  Scenario: Check Stdout for multiple lines
    When I run 'shopt -s xpg_echo ; echo "one\n\one\none\n"'
    Then 'one' should appear on 'stdout' '3' times

  @steps
  Scenario: Check exit code
    When I run 'true'
    Then it should exit '0'

  @steps
  Scenario: Check exit code
    When I run 'false'
    Then it should exit '1'

