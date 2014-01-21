Feature: User management
  In order to view catchr data
  As a person who loves myself
  I want to be able to manage my account

  Background: 
    Given I am on the homepage

  @omniauth_test
  Scenario: Sign up with Twitter
    Given I sign in with "Twitter" 
    When I fill in "Email" with "test@tester.com" and click "Sign up"
    Then I should see "Logout"

  @omniauth_test
  Scenario: Sign in with Twitter
    Given I have signed up already signed up with "Twitter"
    When I click to sign in with "Twitter"
    Then I should see "Logout"