# language: pt
Funcionalidade: Autenticação
  Para garantir que os participantes são quem eles dizem ser
  Como administrador do exeperimento
  Eu quero que os participantes se identifiquem através de login e senha
  
@wip
Cenário: Fazendo login
  Dado que existe um participante com e-mail "foo@email.com" e senha "secret"
  E que estou deslogado
  Quando eu for para a página de login
  E preencho o formulário com:
  | E-mail | foo@email.com |
  | Senha  | secret        |
  E aperto "Login"
  Então devo ver "foo@email.com" em "#user-nav"
  E devo ver "Sair" em "#user-nav"
  
