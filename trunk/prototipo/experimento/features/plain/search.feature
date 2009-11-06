# language: pt
Funcionalidade: Busca de produtos
  Para encontrar produtos
  Como um participante
  Eu quero utilizar um mecanismo de busca

Esquema do Cenário: buscando produtos
  Dado que a etapa 2 está habilitada
  E que existe um participante com e-mail "user@email.com" e senha "secret"
  E que "user@email.com" está na etapa 2 
  E que estou logado como "user@email.com" com a senha "secret" 
  E que existem os seguintes produtos:
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
  Quando eu vou para a página principal
  E preencho "Buscar" com "<busca>"
  E seleciono "<categoria>" na "Categoria"
  E aperto "Buscar"                
  Então não devo ver "<o_que_nao_devo_ver>" em "#productList"
  Então devo ver "<o_que_devo_ver>" em "#productList"
  
Exemplos:
  | busca                | o_que_devo_ver                | categoria   | o_que_nao_devo_ver | 
  |                      |                               |             | harry          | 
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
  