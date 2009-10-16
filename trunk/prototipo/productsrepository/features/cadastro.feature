Feature: Cadastro
  In order to value
  As a role
  I want feature 
  
  Scenario: title
    Given I receiced a link throgh email
    When I click this link
    And I fill in the following:
    | Nome | Leo |
    | login | leobessa |
    | senha | change-me |
    | Faixa etária |  20-25|
    | Sexo | M |
    And I press "OK"
    Then I should see  "Bem vindo, leobessa"
  
  
  

  
