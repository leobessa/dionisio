Feature: Parsing submarino offers
  In order to populate the offer repository with real data
  As an admin
  I want to make html scraping in submarino website
  
  Scenario: The offer is avaiable
    Given the uri 'http://www.submarino.com.br/produto/10/21620474' is at the 'available-product.html' file
    When I fetch the offer in 'http://www.submarino.com.br/produto/10/21620474'
    Then the offer name should be 'iPod Touch 8GB - Preto - Apple'
    And the offer brand should be 'APPLE'
    And the offer list_price should be '67900' as integer
    And the offer link should be 'http://www.submarino.com.br/produto/10/21620474'
    And the category name of the offer should be 'Informática & Acessórios'
    And the offer img_src should be 'http://i.s8.com.br/images/software/cover/img4/21620474.jpg'
    And the offer img_alt should be 'ipod+touch+8gb+-+preto+-+apple'
  
  Scenario: The offer is unavaiable
    Given the uri 'http://www.submarino.com.br/produto/10/21319113' is at the 'unavaliable-product.html' file
    When I fetch the offer in 'http://www.submarino.com.br/produto/10/21319113'
    Then the offer name should be 'iPod Touch 16GB - Apple'
    And the offer brand should be 'APPLE'
    And the offer list_price should be nil
    And the offer link should be 'http://www.submarino.com.br/produto/10/21319113'
    And the category name of the offer should be 'Informática & Acessórios'
    And the offer img_src should be 'http://i.s8.com.br/images/software/cover/img3/21319113.jpg'
    And the offer img_alt should be 'ipod+touch+16gb+-+apple'
    
  Scenario: The offer is lauching
    Given the uri 'http://www.submarino.com.br/produto/3/21575031' is at the 'ronaldo.html' file
    When I fetch the offer in 'http://www.submarino.com.br/produto/3/21575031'
    Then the offer name should be 'Pré-Venda: Minicraques Caricato - Ronaldo'
    And the offer brand should be 'Gibi Brinquedos'
    And the offer list_price should be '7990' as integer
    And the offer link should be 'http://www.submarino.com.br/produto/3/21575031'
    And the category name of the offer should be 'Brinquedos'
    And the offer img_src should be 'http://i.s8.com.br/images/toys/cover/img1/21575031.jpg'
    And the offer img_alt should be 'pre-venda:+minicraques+caricato+-+ronaldo'
  

  
