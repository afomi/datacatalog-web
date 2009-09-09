@keys @users
Feature: 
  In order to obtain a new API key to use
  As a registered user
  I want to generate a new API key
  
  Scenario: Generate a new API key
    Given I am signed in
    When I am on my profile page 
    When I follow "Generate New API Key"
    And I fill in "Purpose" with "To make an awesome dataviz app"
    And I select "Application" from "Key Type"
    And I press "Generate"
    Then I should have a new "application" key with "To make an awesome dataviz app" as its purpose