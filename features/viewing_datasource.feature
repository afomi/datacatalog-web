Feature: Viewing a data source
  In order view the information available on a particular data set
  As Maude, investigative journalist
  I want to be able to see a preview of the data set, some usage examples, comments from others, and general information like source entity, file size, file format, and URL.

  Scenario: Viewing the general annotations
    Given the data source has information like Name, Providing Source, File Formats, File Size, URL, tags et. al.
    When I first view the data source page
    Then I should see those annotations prominently
  
  Scenario: Viewing a preview of the data
    Given the data source is a CSV with header rows
    When I view the Data Preview section
    Then I should see a preview of the CSV with headers and the first three rows displayed
  
  Scenario: Viewing usage examples
    Given the data source has been used in two ProPublica news articles
    When I view the Usage Examples section
    Then I should see a list of links to those articles
  
  Scenario: Viewing comments from others
    Given the data source is popular and others have left comments
    When I view the Comments section
    Then I should be able to view the comments, see a link to the authors, and see the timestamps for those comments
  
  Scenario: Viewing recommendations of similar data sources
    Given the data source is related to other data sources in the catalog
    When I view the Similar Data Sources section
    Then I should see a list of those similar data sources, with a clue on how they are similar to the current source