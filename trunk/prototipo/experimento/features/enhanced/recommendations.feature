# language: pt             
Funcionalidade: Recomendação de produtos
  Para encontrar produtos relevantes
  Como um potencial consumidor
  Eu quero receber recomendações de produtos que eu provavelmente goste
  
  @wip
  Cenário: Avaliando 20 produtos para o mecanismo de filtragem colaborativa
    Dado que a etapa 1 está habilitada
    E que estou na etapa 1 
    E que estou logado
    E que existem 20 produtos pre-selecionados
    Quando eu vou para a página principal
    Então devo ver "Etapa 1" 
    E devo ver os produtos a serem avaliados inicialmente
    Quando eu avaliar todos produtos previamente selecionados
    E eu vou para a página principal 
    Então devo ver "Etapa 2"
    

  
