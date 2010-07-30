@sources
Feature: Help document a data source
  In order share my knowledge about a data source
  As a registered user
  I want edit a wiki-like documentation are for the data source

  Scenario: Edit documentation text
    Given I am viewing documentation for a data source
    When I edit the documentation text in Markdown
    Then the documentation text is updated with my edits
    And a diff is generated and attributed to me

  Scenario: View documentation history
    Given I am viewing documentation for a data source
    When I click on the "History" link for the documentation
    Then I can view the diff change history for the documentation text
