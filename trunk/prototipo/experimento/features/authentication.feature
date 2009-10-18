# language: pt
Funcionalidade: Autenticação
  Para garantir que os participantes são quem eles dizem ser
  Como administrador do exeperimento
  Eu quero que os participantes se identifiquem através de login e senha

  
Cenário: Fazendo login
  Dado que existe um participante habilitado com e-mail "foo@email.com" e senha "qwerty"
  E que estou deslogado
  Quando eu for para a página de login
  E preencher o formulário com:
  | E-mail | foo@email.com |
  | Senha  | qwerty        |
  E apertar o botão "Login"
  Então devo ver "foo@email.com" em "#user-nav"
  E devo ver "Sair" em "#user-nav"
  
