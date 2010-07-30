@miscellany @submissions
Feature: Contact Us
  In order to ask about the curation process on the site
  As a user
  I want to send in a question about it

  Scenario: Use contact form as a site visitor
    Given I am a site visitor
    When I go to the contact form
    And I fill in "Name" with "Ted Allen"
    And I fill in "Email" with "ted@email.com"
    And I fill in "Comments" with "Some message."
    And I press "Submit"
    Then I should see "Your message has been received"

  Scenario: Use contact form as a site visitor without filling in email
    Given I am a site visitor
    When I go to the contact form
    And I fill in "Name" with "Ted Allen"
    And I fill in "Comments" with "Some message."
    And I press "Submit"
    Then I should see "Your name and email are required"

  Scenario: Use contact form but leave no comments
    Given I am a site visitor
    When I go to the contact form
    And I fill in "Name" with "Ted Allen"
    And I fill in "Email" with "ted@email.com"
    And I press "Submit"
    Then I should see "Comments can't be blank"

  Scenario: View contact form as logged in user
    Given I am signed in
    When I go to the contact form
    Then I should not see "Name"
    And I should not see "Email"

  Scenario: Use contact form as logged in user
    Given I am signed in
    When I go to the contact form
    And I fill in "Comments" with "Some message."
    And I press "Submit"
    Then I should see "Your message has been received"