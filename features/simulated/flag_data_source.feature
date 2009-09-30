@sources
Feature: Flag data source as bad
  In order to report that a data set is no longer available at the current URL
  As a registered user
  I want to flag the data set and leave a comment describing the problem
  
  Scenario: Flag a data source as bad
    Given I am viewing a data source that appears to no longer exist
    When I click on a "Flag as Bad" icon
    And leave a comment describing the issue
    Then the data source is marked as "Flagged as Bad"
    And my comment is displayed prominently on the page
    And the site curators are emailed about the problem