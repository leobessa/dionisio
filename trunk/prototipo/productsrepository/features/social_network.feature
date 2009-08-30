Feature: Find and Add Friends
  In order to engage with a lot of other users
  As a user
  I want to find my and track my friends
  
  Scenario: Finding a friend by username  
    Given the following user records
          | username| password|
          | john.doe| secret  |
          | alfred  | secret  |
    When I go to /users
    And I fill in "search" with "john.doe"
    And I press "Search"
    Then I should see "john.doe"
    And I should not see "alfred"
  

  
