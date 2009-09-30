@sources
Feature: Comment on a data source
  In order to share some tips and tricks learned about the data
  As a registered user
  I want to leave some detailed comments about it
  
  Scenario: Leave comment with a positive rating
    Given I am viewing a data source that I found useful
    When I click on a Thumbs Up icon for it
    And I leave a comment describing how useful it is
    Then my thumbs up vote should be recorded and applied to the score
    And my comment should be displayed
  
  Scenario: Give a negative rating to a data source
    Given I am viewing a data source I did not find useful
    When I click on the Thumbs Down icon for it
    Then my vote should be recorded and applied to the score
    
  Scenario: File a bug report
    Given I am viewing a data source where I found a small problem with the data
    When I click on the Bug icon for it
    And leave a comment describing the bug
    Then my bug report is displayed as a comment
    And my bug report is emailed to the producing entity of that data source