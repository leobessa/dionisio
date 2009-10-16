Feature: Common products rating
  In order to value
  As a role
  I want feature               
  
  Scenario: Rating 20 products
    Given I am logged in
    And I on products rating phase
    When I go to the home page
    Then I should see "Etapa de avalição inicial de produtos"
    Then I should see a list with 20 products for rating
  
  
  

  
