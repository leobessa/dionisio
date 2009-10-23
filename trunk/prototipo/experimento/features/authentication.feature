# language: pt
Funcionalidade: Autenticação
  Para garantir que os participantes são quem eles dizem ser
  Como administrador do exeperimento
  Eu quero que os participantes se identifiquem através de login e senha
  
Cenário: Fazendo login
  Dado que sou o usuário "foo@email.com" com senha "secret"
  E que estou logado
  Então devo ver "foo@email.com"
  E devo ver "Sair" em "#user_nav"
  
