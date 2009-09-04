Feature: Add more capacity
  In order to better manage my trucks and loads
  Dispatchers should be able to
  add capacity to a hot sheet 

  Scenario: Adding new capicity for today
    Given I am looking at today's capacity
    When I click the link "AddMoreCapacity"
    And I fill in "Location" with "Kansas City"
    And I fill in "Driver" with "Leroy"
    And I fill in "Available On" with Todays Date
    And I fill in "Notes" with "need a hot load"
    When I press "save"
    Then I should see more capicity in "Kansas City" for today
