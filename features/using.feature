# For complete reusable step listings see:
# lib/aruba/cucumber.rb
# https://github.com/aslakhellesoy/aruba/blob/master/lib/aruba/cucumber.rb
# AND
# lib/cuken/*.rb
# https://github.com/hedgehog/cuken

Feature: Using features
  To test websites
  And other infrastructure
  An operator
  Needs helper tools
  To create and run features

  Background:
    Given cucumber-nagios is installed
    Given I successfully run "cucumber-nagios-gen project using-tests"
    And I cd to "using-tests"

  @using
  Scenario: Create a feature
    Given I successfully run "cucumber-nagios-gen feature github.com login"
    Then the output should contain:
      """
      Generating with project generator:
           [ADDED]  .gitignore
           [ADDED]  .bzrignore
           [ADDED]  Gemfile
           [ADDED]  features/steps
           [ADDED]  features/support
           [ADDED]  README

      Your new cucumber-nagios project can be found in /usr/src/cucumber-nagios/tmp/aruba/using-tests.

      Next, install the necessary RubyGems with:

          bundle install

      Your project has been initialised as a git repository.

      Generating with feature generator:
           [ADDED]  features/github.com/login.feature
           [ADDED]  features/github.com/steps/login_steps.rb
      """

  @using
  Scenario: Run a successful feature
    Given I successfully run "cucumber-nagios-gen feature google.com homepage"
    When I successfully run "cucumber-nagios features/google.com/homepage.feature"
    Then the output should contain:
      """
      CUCUMBER OK - Critical: 0, Warning: 0, 2 okay | passed=2; failed=0; nosteps=0; total=2;
      """

  @using
  Scenario: Run a feature without steps
    Given I successfully run "cucumber-nagios-gen feature github.com profile"
    And the file "features/github.com/profile.feature" with:
    """
      Feature: Failure
        Scenario: The only option
          Given the output should contain "supercalifragilisticexpialidocious"
    """
    When I run "cucumber-nagios features/google.com/profile.feature"
    Then the exit status should be 4

# We should really switch to Capybara and friends ASAP
#  @using
#  Scenario: webrat.log output
#    When I generate the feature "homepage" for "github.com"
#    Then the "homepage" feature on "github.com" should exit cleanly
#    Then "webrat.log" in the "passing-features" project should not exist

  @using
  Scenario: Multiline output
    Given I successfully run "cucumber-nagios-gen feature google.com profile"
    And the file "features/google.com/profile.feature" with:
    """
      Feature: Failure
        Scenario: The only option
          Given the output should contain "supercalifragilisticexpialidocious"
    """
    When I run "cucumber-nagios features/google.com/profile.feature"
    Then the output from "cucumber-nagios features/google.com/profile.feature" contains:
    """
    CUCUMBER CRITICAL - Critical: 1, Warning: 0, 0 okay | passed=0; failed=1; nosteps=0; total=1;
    """
