# language: pt
Funcionalidade: Autenticação
  Para garantir que os participantes são quem eles dizem ser
  Como administrador do exeperimento
  Eu quero que os participantes se identifiquem através de login e senha
  
Cenário: Fazendo login
  Dado que estou logado
  Então devo ver "user@email.com"
  E devo ver "Sair"
  
