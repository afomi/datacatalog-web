@signup
Feature: Sign up
  In order to register an account for the website
  As a site visitor
  I want to enter in some credentials and create an account

  Scenario: Sign up with email/password
    Given I am a site visitor
    When I go to sign up
    And I fill in "Name" with "John D."
    And I fill in "Email" with "john@test.com"
    And I fill in "Password" with "s3krit"
    And I fill in "Confirm Password" with "s3krit"
    And I press "Sign Up"
    Then my account should be created
    And I should see "Please check your email inbox to confirm your email address"

  Scenario: Sign up with wrong password confirmation
    Given I am a site visitor
    When I go to sign up
    And I fill in "Name" with "Jack D."
    And I fill in "Email" with "jack@test.com"
    And I fill in "Password" with "s3krit"
    And I fill in "Confirm Password" with "sekrit"
    And I press "Sign Up"
    Then my account should not be created
    And I should see "Password doesn't match confirmation"

  Scenario: Attempt to sign up with email address already in system
    Given I am a site visitor who already has signed up with "jane@test.com"
    When I go to sign up
    And I fill in "Name" with "Jane D."
    And I fill in "Email" with "jane@test.com"
    And I fill in "Password" with "s3krit"
    And I fill in "Confirm Password" with "s3krit"
    And I press "Sign Up"
    Then I should see "Email has already been taken"

  Scenario: Confirm my email address after signing up
    Given I have signed up but not yet confirmed
    When I click on the confirmation link
    Then I should see "Your email address has been confirmed"

  Scenario: Sign up with OpenID
    Given I am a site visitor
    When I go to sign up
    And I fill in "OpenID URL" with "http://johndoe.myopenid.com/"
    And I fill in "openid_name" with "John D."
    And I fill in "openid_email" with "john@test.com"
    And I press "Sign Up via OpenID"
    Then my OpenID-enabled account should be created
    