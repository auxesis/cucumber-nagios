Feature: SSH steps
  In order to specify remote command execution
  As a developer using Cucumber
  I want to use Aruba and custom steps to describe SSH sessions

  Background:
    Given that "cuken/ssh" is required
    And the Gem "ssh-forever" has been required
    And default ssh-forever options
    And I initialize password-less SSH access

  Scenario: Aruba steps for remote commands via password-less SSH access
    Given I successfully run "ssh cuken 'echo Supercalifragilisticexpialidocious;'"
    Then the output should contain "Supercalifragilisticexpialidocious"

  Scenario: Batch initialize password-less SSH access
    When I initialize password-less SSH access for:
      | user      | hostname   | name         | port        |
      | `whoami`  | `hostname` | `echo cuken` | `echo 22`   |
      | :default  | localhost  | `echo cuken` | 22          |
      | :default  | :default   | :default     | :default    |
    And I successfully run "ssh cuken 'echo Supercalifragilisticexpialidocious;'"
    Then the output should contain "Supercalifragilisticexpialidocious"
