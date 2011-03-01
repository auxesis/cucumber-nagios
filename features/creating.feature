Feature: Creating new project
  To test websites
  A cucumber-nagios project
  Must be created

  @create
  Scenario: Create a project
    Given cucumber-nagios is installed
    When I create a new project called "great-website-tests"
    And I freeze in dependencies
    Then a Gemfile lock should be created

  @create
  Scenario: Pretend to create a project
    Given cucumber-nagios is installed
    When I pretend to create a new project called "greatest-website-tests"
    Then I do not freeze in dependencies
    And a Gemfile lock should not be created
