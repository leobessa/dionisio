# language pt
Funcionalidade: Restrição de cadastro através de convite
 Para restringir o acesso ao experimento
 Como responsável pelo experimento
 Quero enviar convites para os participantes
 
 @wip
 Cenário: Envio de convite para participante
   Dado que estou logado como adminstrador
   E estou na pagina de envio de convites
   E preencho "e-mail" com "convidado@email.com"
   E aperto "Enviar convite"
   Então devo ver "Convite enviado para convidado@email.com"
   E um e-mail deve ter sido enviado para "convidado@email.com"
 
 Cenário: Casdastro de participante convidado
   Dado que que recebi um convite no e-mail "joao@email.com.br"
   Quando clicar no link "cadastrar" enviado no e-mail
   Então eu devo estar na página de cadastro de participante

   Quando eu preencher o formulário com:
   | Nome                | João da Silva     |
   | Senha               | change-me         |
   | Confimação da senha | change-me         |
   E escolher a opção "Masculino"
   E selecionar "18-25" na "Faixa etária"  
   E apertar o botão "Criar minha conta."
   Então devo estar na página principal
   E ver "Sua conta foi criada com sucesso"