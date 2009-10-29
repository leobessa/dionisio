# language: pt             
Funcionalidade: Recomendação de produtos
  Para encontrar produtos relevantes
  Como um potencial consumidor
  Eu quero receber recomendações de produtos que eu provavelmente goste
  
  Cenário: Avaliando 20 produtos para o mecanismo de filtragem colaborativa
    Dado que a etapa 1 está habilitada
    Dado que existe um participante com e-mail "user@email.com" e senha "secret"
    E que "user@email.com" está na etapa 1 
    E que estou logado como "user@email.com" com a senha "secret"
    E que existem 20 produtos pre-selecionados
    Quando eu vou para a página principal
    Então devo ver "Etapa 1" 
    E devo ver os produtos a serem avaliados inicialmente
    Quando eu avaliar todos produtos previamente selecionados
    Então devo ver "Etapa 2" 
    
  Cenário: Avaliando 10 produtos escolhidos pelo usuário
    Dado que a etapa 2 está habilitada
    E que existe um participante com e-mail "user@email.com" e senha "secret"
    E que "user@email.com" está na etapa 2 
    E que estou logado como "user@email.com" com a senha "secret"
    Então devo ver "Etapa 2"
    Dado que existem 10 produtos ainda não avaliados por "user@email.com"
    Quando avalio mais 10 produtos ainda não avaliados por "user@email.com"
    Quando eu vou para a página principal  
    Então devo ver "Etapa 3"  


  
  
  
    

  
  
  
