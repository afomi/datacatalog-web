@miscellany @submissions
Feature: Submit data source
  In order to submit information about a new data set
  As a user
  I want to be able to fill in a form with pertinent data and comments
  
  Scenario: Use submission form as a site visitor
    Given I am a site visitor
    When I go to the data source submission form
    And I fill in "Your Name" with "Ted Allen"
    And I fill in "Your Email" with "ted@email.com"
    And I fill in "Data Source Title" with "Vampire Bat Data"
    And I fill in "Data Source URL" with "http://vampire.bat"
    And I fill in "Comments" with "They can be dangerous."
    And I press "Submit"
    Then I should see "Your submission has been received"

  Scenario: Use submission form as a site visitor without filling in email
    Given I am a site visitor
    When I go to the data source submission form
    And I fill in "Your Name" with "Ted Allen"
    And I fill in "Data Source Title" with "Vampire Bat Data"
    And I fill in "Data Source URL" with "http://vampire.bat"
    And I press "Submit"
    Then I should see "Your name and email are required"

  Scenario: Use submission form as a site visitor without filling in URL
    Given I am a site visitor
    When I go to the data source submission form
    And I fill in "Your Name" with "Ted Allen"
    And I fill in "Your Email" with "ted@email.com"
    And I fill in "Data Source Title" with "Vampire Bat Data"    
    And I press "Submit"
    Then I should see "Data Source URL can't be blank"

  Scenario: View submission form as logged in user
    Given I am signed in
    When I go to the data source submission form
    Then I should not see "Your Name"
    And I should not see "Your Email"

  Scenario: Use submission form as logged in user
    Given I am signed in
    When I go to the data source submission form
    And I fill in "Data Source Title" with "Vampire Bat Data"
    And I fill in "Data Source URL" with "http://vampire.bat"
    And I fill in "Comments" with "They can be dangerous."
    And I press "Submit" 
    Then I should see "Your submission has been received"
