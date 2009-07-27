Feature: Request an API key
  In order to gain access to the API
  As a registered user
  I want to request a new API key

  Scenario: Request an API key
    Given I am a signed in user on My Account page
    When I view the "My API Keys" section
    And fill out a text field for "Intended Usage:"
    And click on "Request API Key"
    Then a new API key will be generated for me

