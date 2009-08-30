Feature: Make Recommendations
  In order to find items that I would probably like
  As a user
  I want to receive recommendations
  
  Scenario: Finding items based on collaborative filtering
    Given the following reviews
      | username| product | rating|
      | joao    | ipod    | 5     |
      | joao    | windows | 0     |
      | joao    | mac     | 5     |
      | alfred  | ipod    | 5     |
      | alfred  | windows | 0     |  
    When I go to "alfred" recommendations page
    Then I should see "Product Recommendations"
    And I should see "mac"
    And I should see "5"
