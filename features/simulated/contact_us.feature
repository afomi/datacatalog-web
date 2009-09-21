@miscellany @contact

Feature: Contact Us
  In order to ask about the curation process on the site
  As a user
  I want to send in a question about it
  
  Scenario: Use contact form as a site visitor
    Given I am a site visitor
    When I go to the contact form
    And I fill in "Your Name" with "Ted Allen"
    And I fill in "Your Email" with "ted@email.com"
    And I fill in "Your Comments" with "Some message."
    And I press "Submit"
    Then I should see "Your message has been received"

  Scenario: Use contact form but leave no comments
    Given I am a site visitor
    When I go to the contact form
    And I fill in "Your Name" with "Ted Allen"
    And I fill in "Your Email" with "ted@email.com"
    And I press "Submit"
    Then I should see "Comments can't be blank"