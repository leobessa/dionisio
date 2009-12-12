Feature: Registration
  In order to be identified
  As a user
  I want to my register my personal account
  
  Given I am on new user page
  When I fill in the following:
       | E-mail               | user@email.com |
       | Senha                | secret         |
       | Confirmação da Senha | secret         |
  And I press "Criar minha conta"
  Then I should see "Seu cadastro foi realizado com sucesso." 


  
