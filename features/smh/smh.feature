Feature: smh.com.au
  It should be up
  And provide links to content

  Scenario: Visiting home page
    When I go to http://smh.com.au/
    Then I should see site navigation
    And there should be a section named "Opinion"

