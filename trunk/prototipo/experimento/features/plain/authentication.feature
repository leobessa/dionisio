# language: pt
Funcionalidade: Autenticação
  Para garantir que os participantes são quem eles dizem ser
  Como administrador do exeperimento
  Eu quero que os participantes se identifiquem através de login e senha
  
Cenário: Fazendo login
  Dado que existe um participante com e-mail "user@email.com" e senha "secret"
  E que estou logado como "user@email.com" com a senha "secret"
  Então devo ver "user@email.com"
  E devo ver "Sair"
  
