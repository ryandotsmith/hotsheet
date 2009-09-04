Feature: Add more capacity
  In order to better manage my trucks and loads
  Dispatchers should be able to
  add capacity to a hot sheet 

  Scenario: Adding new capicity for today
    Given I am looking at today's capacity
    When I click "Add More Capacity"
    And I fill in "location" with "Kansas City"
    And I fill in "driver" with "Leroy"
    And I fill in "available on" with Todays Date
    And I fill in "notes" with "need a hot load"
    When I press "save"
    Then I should see more capicity for today
