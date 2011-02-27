Feature: Installation
  To set up a cucumber-nagios project
  A user
  Must be able to install the gem

  @install
  Scenario: Installing the gem
    When I build the gem
    And I install the latest gem
    Then I should have "cucumber-nagios-gen" on my path
    And I should have "cucumber-nagios" on my path
    And I can generate a new project

