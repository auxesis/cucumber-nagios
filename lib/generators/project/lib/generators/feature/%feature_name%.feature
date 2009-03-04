Feature: <%= site %>
  It should be up

  Scenario: Visiting home page
    When I go to http://<%= site %>
    Then the request should succeed

