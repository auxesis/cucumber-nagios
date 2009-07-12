Feature: Creating new project 
  To test websites 
  A cucumber-nagios projert
  Must be created

  Scenario: Create a project
    Given cucumber-nagios is installed
    When I create a new project called "great-website-tests"
    And I freeze in dependencies
    Then my gems directory should be populated
    
