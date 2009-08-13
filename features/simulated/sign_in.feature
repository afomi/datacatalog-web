@signin @users
Feature: Sign in
  In order to sign in
  As a registered user
  I want to enter my email/password to sign in

  Scenario: Sign in
    Given I have signed up and confirmed
    When I go to sign in
    And I fill in "Email" with "some@email.com"
    And I fill in "Password" with "test"
    And I press "Sign In"
    Then I should see "You have been signed in"

  Scenario: Attempt to sign in without confirming
    Given I have signed up but not yet confirmed
    When I go to sign in
    And I fill in "Email" with "some@email.com"
    And I fill in "Password" with "test"
    And I press "Sign In"
    Then I should see "Your account is not confirmed"
