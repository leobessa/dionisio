# language: pt
Funcionalidade: Autenticação
  Para garantir que os participantes são quem eles dizem ser
  Como administrador do exeperimento
  Eu quero que os participantes se identifiquem através de login e senha
  
Cenário: Fazendo login
  Dado que estou logado como usuário "foo@email.com"
  Então devo ver "foo@email.com" em "#user_nav"
  E devo ver "Sair" em "#user_nav"
  
