Feature: Using features
  To test websites
  And other infrastructure
  An operator
  Needs helper tools
  To create and run features

  @using
  Scenario: Create a feature
    Given cucumber-nagios is installed
    And a project called "more-great-tests" is created and frozen
    When I generate a new feature called "login" for "github.com"
    Then a feature file should exist for "login" on "github.com"

  @using
  Scenario: Run a successful feature
    Given a project called "passing-features" is created and frozen
    When I generate a new feature called "homepage" for "github.com"
    Then the "homepage" feature on "github.com" should exit cleanly

  @using
  Scenario: Run a failing feature
    Given a project called "failing-features" is created and frozen
    When I generate a new feature called "profile" for "github.com"
    And the "profile" feature on "github.com" checks for something preposterous
    Then the "profile" feature on "github.com" should not exit cleanly

  @using
  Scenario: webrat.log output
    Given a project called "passing-features" is created and frozen
    When I generate a new feature called "homepage" for "github.com"
    Then the "homepage" feature on "github.com" should exit cleanly
    Then "webrat.log" in the "passing-features" project should not exist

  @using
  Scenario: Multiline output
    Given a project called "multiline-output" is created and frozen
    When I generate a new feature called "profile" for "github.com"
    And the "profile" feature on "github.com" checks for something preposterous
    Then the "profile" feature on "github.com" should not exit cleanly
    And the "profile" feature on "github.com" should produce multiline output
