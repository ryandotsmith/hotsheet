Feature: Add more capacity
  In order to better manage my trucks and loads
  Dispatchers should be able to
  add capacity to a hot sheet 

  Scenario: Adding new capicity for today
    Given I am looking at today's capacity
    And I fill in "Location" with "Kansas City"
    And I fill in "Driver" with "Leroy"
    And I select "09/05/2009" as the date
    And I fill in "Notes" with "need a hot load"
    When I press "save"
    Then I should see "More capacity was added in Kansas City"
