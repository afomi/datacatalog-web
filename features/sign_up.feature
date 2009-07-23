Feature: Sign up
  In order to register an account for the website
  As a site visitor
  I want to enter in some credentials and create an account
  
  Scenario: Sign up with OpenID
    Given I am a site visitor who knows my OpenID
    When I choose to Sign Up
    And I select the OpenID option
    And enter in my OpenID
    Then an account is created for me from my OpenID
    
  Scenario: Sign up with email/password
    Given I am a site visitor
    When I choose to Sign Up
    And enter in my email address and password
    Then an account is created for me
    
  Scenario: Attempt to sign up with email address already in system
    Given I am a site visitor who already has signed up
    When I choose to Sign Up
    And enter in my email address and password
    Then I am told that I already have an account
    And am signed in automatically if my password matches

