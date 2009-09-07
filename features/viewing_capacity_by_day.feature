Feature: Viewing capaicities by day
  As a dispatcher
  In order to plan capacities for the future 
  I need to view capacity for today and three days out

  Background:
    Given I have a capacity today in "Kansas City"
    And I have capacity "1" day from now in "Tuscan"
    And I have capacity "2" days from now in "Oklahoma"

  Scenario: Viewing Capacity for today
    Given I am looking at today's capacity
    Then I should see capacity in "Kansas City" for "today"
    And I should see capacity in "Tuscan" "1" day from now
    And I should see capacity in "Oklahoma" "2" days from now

  Scenario: Focusing on new capacities
    Given I am looking at today's capacity
    And I have future capacity
    When I click on a capacity in the future
    Then the future capacity should come into focus
