Feature: Autentication
  In order to be identified
  As a user
  I want to login and logout

  Scenario: Login as a registered user
    Given I am not logged in
    When I am logged in as "rato" with password "rato"
    Then I should be logged in as "rato"
    And I should see "Logout"  
    
  Scenario: Logout
    Given I am logged in as "rato" with password "rato"
    When I follow "Logout"
    Then I should not be logged in
  
  
  
    
  
  
    
