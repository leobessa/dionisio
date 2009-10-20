# language pt             
Funcionalidade: Recomendação de produtos
  Para encontrar produtos relevantes
  Como um potencial consumidor
  Eu quero receber recomendações de produtos que eu provavelmente goste
  
  @wip
  Cenário: Avaliando 20 produtos para o mecanismo de filtragem colaborativa
    Dado que sou um participante na etapa 1
    Quando vou para a página principal
    Então devo ver "Etapa 1" em "#phase-description"
    E devo ver 20 produtos a serem avaliados
    Quando eu avaliar todos os 20 produtos
    Então eu devo ver "Etapa 1 concluída" em "#phase-status"
    

  
