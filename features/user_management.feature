Feature: User management
  In order to view catchr data
  As a person who loves myself
  I want to be able to manage my account

  # Background: 
  #   Given I am on the homepage

  @omniauth_test
  Scenario: Sign in
    before do 
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] 
    end
    Given I am on the homepage
    When I sign in with "Twitter"
    Then I should see "Logout"
