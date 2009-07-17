Feature: Watch data source
  In order to easily find a data source later
  As a registered user
  I want to choose to Watch the data source, and access it from my Watch Lists later

  Scenario: Watch current data source
    Given that I am viewing a data source and have only one default watch list (named "My Watch List")
    When I click on the "Watch" link
    Then the data source is added to "My Watch List"

  Scenario: Unwatch current data source
    Given that I am viewing a data source that I am currently watching, listed under "My Watch List"
    When I click on the "Unwatch" link
    Then the data source is no longer on "My Watch List"

  Scenario: Create a new custom Watch List
    Given that I am viewing my Watch Lists, currently consisting of a single watch list named "My Watch List"
    When I click on the "New Watch List" link
    And I give it a name of "Farm Data"
    Then a new, empty watch list named "Farm Data" is available to use
    
  Scenario: Save current data source to custom watch list
    Given that I am viewing a data source and have a custom watch list named "Farm Data"
    When I click on the "Watch" link
    And I choose to save it to "Farm Data" when prompted
    Then the data source is added to my "Farm Data" watch list
    
  Scenario: Move data source from one watch list to another
    Given that I am viewing my Watch lists
    And I have a watch list named "My Watch List"
    And I have a watch list named "Farm Data"
    When I drag a data source from "My Watch List" to "Farm Data"
    Then the data source is moved from "My Watch List" to "Farm Data"

  Scenario: Remove a custom watch list
    Given that I am viewing my Watch lists
    And I have a custom watch list named "Farm Data"
    When I click on the remove link for that watch list
    And I confirm that removing the watch list will "Mark all data sources contained in this as Unwatched"
    Then the watch list is removed