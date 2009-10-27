@wip
Scenario Outline: buscando produtos
  Given que a etapa 2 está habilitada
  Given que existe um participante com e-mail "user@email.com" e senha "secret"
  And que "user@email.com" está na etapa 2 
  And que estou logado como "user@email.com" com a senha "secret" 
  And que existem estes produtos:
  | name                 | description                   | category    |
  | harry potter         | harry potter 1                | Livros      |
  | macbook white        | computador macbook cor branca | Eletrônicos |
  | ipod touch           | tocador de música ipod touch  | Eletrônicos |
  | channel 1            | perfume channel 1             | Perfumaria  |
  | Televisor CCE 14     | televisor CCE                 | Eletrônicos |
  | Camisa regata Hering | Camisa regata Hering          | Roupas      |
  | CD Iron Maiden       | CD Iron Maiden                | CDs         |
  | CD U2                | CD U2                         | CDs         |
  | CD U3                | CD U3                         | CDs         |
  | CD U4                | CD U4                         | CDs         |
  When eu vou para a página principal
  When preencho o formulário com:
  |Buscar|<busca>| 
  And seleciono "<categoria>" na "Categoria"
  And aperto "Buscar"                
  Then não devo ver "<o_que_nao_devo_ver>" em "#productList"
  Then devo ver "<o_que_devo_ver>" em "#productList"
  
Examples:
  | busca                | o_que_devo_ver                | categoria   | o_que_nao_devo_ver | 
  |                      | CD Iron Maiden                | CDs         | harry          |
  | harry                | harry potter 1                | Livros      | perfume        |
  | macbook              | computador macbook cor branca | Eletrônicos | harry          |
  | ipod touch           | tocador de música ipod touch  | Eletrônicos | macbook        |
  | channel 1            | perfume channel 1             | Perfumaria  | CD             |
  | Televisor CCE 14     | televisor CCE                 | Eletrônicos | regata         |
  | Camisa regata Hering | Camisa regata Hering          | Roupas      | U2             |
  | Iron Maiden          | CD Iron Maiden                | CDs         | U3             |
  | CD U2                | CD U2                         | CDs         | perfume        |
  | CD U3                | CD U3                         | CDs         | camisa         |
  | CD U4                | CD U4                         | CDs         | ipod           |
