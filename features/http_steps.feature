Feature: HTTP interations

  @steps
  Scenario: File exists
    Given I am HTTP digest authenticated with the following credentials:
     | username | password |
     | foo      | bar      |
    When I go to "http://www.google.com.au/"
    Then I should see "Feeling Lucky"

