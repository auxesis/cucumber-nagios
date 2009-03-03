Feature: holmwood.id.au
  It should be up

  Scenario: Visiting home page
    When I go to http://holmwood.id.au/~lindsay/
    Then I should see "survivor. sysadmin. cyclist."

