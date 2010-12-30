Feature: <%= site %>
  It should be up

  Scenario: Visiting home page
    When I visit "http://<%= site %>"
    Then the request should succeed

